From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 10:40:37 -0500
Subject: [PATCH v5 07/14] KVM: ARM: World-switch implementation
In-Reply-To: <20130116125712.GT11529@redhat.com>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108183924.46302.65998.stgit@ubuntu>
 <20130115094312.GI11529@redhat.com>
 <CANM98q+qScaXniyYjrd9QEZzWKzj3PkCE0YNFUp2ijnCfS_v4w@mail.gmail.com>
 <CANM98qJZcuF95-D=1Qu6cwXUkQrR4a12bZtrZOuP00U2HGkjMQ@mail.gmail.com>
 <20130116125712.GT11529@redhat.com>
Message-ID: <CANM98qJ7O8RT_t0OinGDukdR5PNrObmU0rj6uFGEbT2hCvCjmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>>
>
> Agree. Lets merge it and change later. The vcpu run loop is simple
> enough at this point. The question of using vcpu->requests is not
> the question of "real benefit" though, of course you can introduce your
> own mechanism to pass requests to vcpus instead of using whatever kvm
> provides you. But from maintenance and code share point of view this
> is wrong thing to do. Looks at this code for instance:
>
>         /* Kick out any which are still running. */
>         kvm_for_each_vcpu(i, v, vcpu->kvm) {
>                 /* Guest could exit now, making cpu wrong. That's OK. */
>                 if (kvm_vcpu_exiting_guest_mode(v) == IN_GUEST_MODE) {
>                         force_vm_exit(get_cpu_mask(v->cpu));
>                 }
>         }
>
> Why not make_all_cpus_request(vcpu->kvm, KVM_REQ_PAUSE)?

well for one, make_all_cpus_request is a static function in kvm_main.c
and the semantics of that one is really tricky with respect to locking
and requires (imho) a much clearer explanation with commenting (see
separate e-mail to kvm list). And now is not the time to do this.

>
> And I am not sure KVM_REQ_UNHALT is so useless to you in the first
> place. kvm_vcpu_block() can return even when vcpu is not runnable (if
> signal is pending). KVM_REQ_UNHALT is the way to check for that. Hmm
> this is actually looks like a BUG in the current code.
>
there's no guarantee that you won't be woken up from a WFI instruction
for spurious interrupts on ARM, so we don't care about this, we simply
return to the guest, and it must go back to sleep if that's what it
wants to do.

-Christoffer
