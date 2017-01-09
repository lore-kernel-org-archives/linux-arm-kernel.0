From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 9 Jan 2017 14:28:06 +0000
Subject: [PATCH 1/2] ARM: hyp-stub: improve ABI
In-Reply-To: <20170109125431.GY14217@n2100.armlinux.org.uk>
References: <20161213113044.GC19985@leverpostej>
 <E1cH74w-0003ke-Qp@rmk-PC.armlinux.org.uk>
 <72f93940-cf87-fd91-90f2-760b7ff050fb@arm.com>
 <20170109125431.GY14217@n2100.armlinux.org.uk>
Message-ID: <20170109142806.GB7593@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 12:54:31PM +0000, Russell King - ARM Linux wrote:
> So, we need KVM's stub to be (a) better documented so this stuff is
> obvious, and (b) updated so that kdump stands a chance of working even
> if the KVM stub is still in place at the point the host kernel panics.
> 
> Another reason why documentation is important here is that we need to
> make it clear to alternative hypervisors that the host kernel may issue
> a HVC call at any moment due to a crash with particular arguments, and
> that the host kernel expects a certain behaviour in that case, and that
> the hypervisor does not crash.

The only hypervisor (apart from the hyp-stub) built and deployed
together with the kernel is KVM. On ARM, to be able to enable KVM, the
host kernel must be booted in Hyp mode and install the stub before
dropping to SVC.

With Xen (or a different Type-1 hypervisor), the "host" kernel (dom0 for
Xen, a.k.a. control domain) is booted in SVC mode directly, so hyp-stub
is not installed and is_hyp_mode_available() returns false.

> For example, how will Xen behave - is introducing these changes going
> to cause a regression with Xen?  Does anyone even know the answer to
> that?  From what I can see, it seems we'll end up calling Xen's
> hypervisor with a random r12 value (which it uses as a reason code)
> but without the 0xea1 immediate constant in the HVC instruction.
> Beyond that, I've no idea.

Any HVC calls from the control domain kernel must comply with the ABI
offered by the corresponding hypervisor and has nothing to do with the
hyp-stub ABI. Routing hyp-stub ABI HVC calls to an unaware hypervisor
like Xen as part of kdump/kexec is a kernel bug and would probably
result in the kernel being killed. I haven't tried but kexec in a host
kernel under Xen should work just like kexec in any other guest kernel.

-- 
Catalin
