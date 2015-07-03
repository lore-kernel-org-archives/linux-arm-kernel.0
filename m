From: pbonzini@redhat.com (Paolo Bonzini)
Date: Fri, 3 Jul 2015 09:08:54 +0200
Subject: [RFC 12/17] irq: bypass: Extend skeleton for ARM forwarding
 control
In-Reply-To: <1435843047-6327-13-git-send-email-eric.auger@linaro.org>
References: <1435843047-6327-1-git-send-email-eric.auger@linaro.org>
 <1435843047-6327-13-git-send-email-eric.auger@linaro.org>
Message-ID: <55963506.8020200@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/07/2015 15:17, Eric Auger wrote:
> +	void (*stop_producer)(struct irq_bypass_producer *);
> +	void (*resume_producer)(struct irq_bypass_producer *);

Also, can you call these just "stop"/"resume" ...

> +	void (*add_consumer)(struct irq_bypass_producer *,
> +			     struct irq_bypass_consumer *);
> +	void (*del_consumer)(struct irq_bypass_producer *,
> +			     struct irq_bypass_consumer *);
>  };
>  
>  struct irq_bypass_consumer {
>  	struct list_head node;
>  	void *token;
> -	void (*add_producer)(struct irq_bypass_producer *);
> -	void (*del_producer)(struct irq_bypass_producer *);
> +	unsigned int gsi;		/* the guest gsi */
> +	struct kvm *kvm;
> +	void (*stop_consumer)(struct irq_bypass_consumer *);
> +	void (*resume_consumer)(struct irq_bypass_consumer *);

... and same here?  The KVM functions could be named

- kvm_arch_irq_bypass_add_producer
- kvm_arch_irq_bypass_del_producer
- kvm_arch_irq_bypass_stop
- kvm_arch_irq_bypass_resume

Paolo
