From: borntraeger@de.ibm.com (Christian Borntraeger)
Date: Tue, 22 Aug 2017 09:26:50 +0200
Subject: [PATCH RFC v3 1/9] KVM: s390: optimize detection of started vcpus
In-Reply-To: <20170821203530.9266-2-rkrcmar@redhat.com>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
 <20170821203530.9266-2-rkrcmar@redhat.com>
Message-ID: <f09bdbc8-298f-fa7e-31be-ceaf048681a9@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/21/2017 10:35 PM, Radim Kr?m?? wrote:
> We can add a variable instead of scanning all online VCPUs to know how
> many are started.  We can't trivially tell which VCPU is the last one,
> though.
> 
> Suggested-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Radim Kr?m?? <rkrcmar@redhat.com>



> @@ -3453,16 +3447,12 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
> 
>  void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
>  {
> -	int i, online_vcpus, started_vcpus = 0;

here you remove i.

> -	struct kvm_vcpu *started_vcpu = NULL;
> -
>  	if (is_vcpu_stopped(vcpu))
>  		return;
> 
>  	trace_kvm_s390_vcpu_start_stop(vcpu->vcpu_id, 0);
>  	/* Only one cpu at a time may enter/leave the STOPPED state. */
>  	spin_lock(&vcpu->kvm->arch.start_stop_lock);
> -	online_vcpus = atomic_read(&vcpu->kvm->online_vcpus);
> 
>  	/* SIGP STOP and SIGP STOP AND STORE STATUS has been fully processed */
>  	kvm_s390_clear_stop_irq(vcpu);
> @@ -3470,19 +3460,20 @@ void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
>  	atomic_or(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
>  	__disable_ibs_on_vcpu(vcpu);
> 
> -	for (i = 0; i < online_vcpus; i++) {
> -		if (!is_vcpu_stopped(vcpu->kvm->vcpus[i])) {
> -			started_vcpus++;
> -			started_vcpu = vcpu->kvm->vcpus[i];
> -		}
> -	}
> +	vcpu->kvm->arch.started_vcpus--;
> +
> +	if (vcpu->kvm->arch.started_vcpus == 1) {
> +		struct kvm_vcpu *started_vcpu;
> 
> -	if (started_vcpus == 1) {
>  		/*
> -		 * As we only have one VCPU left, we want to enable the
> -		 * IBS facility for that VCPU to speed it up.
> +		 * As we only have one VCPU left, we want to enable the IBS
> +		 * facility for that VCPU to speed it up.
>  		 */
> -		__enable_ibs_on_vcpu(started_vcpu);
> +		kvm_for_each_vcpu(i, started_vcpu, vcpu->kvm)

here you need i.
> +			if (!is_vcpu_stopped(started_vcpu)) {
> +				__enable_ibs_on_vcpu(started_vcpu);
> +				break;
> +			}
>  	}
> 
>  	spin_unlock(&vcpu->kvm->arch.start_stop_lock);
> 
