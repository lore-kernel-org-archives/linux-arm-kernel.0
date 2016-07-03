From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 3 Jul 2016 23:44:13 +0200
Subject: [PATCH v2 00/18] arm/arm64: KVM: Merge boot and runtime page
 tables
In-Reply-To: <1467308451-13365-1-git-send-email-marc.zyngier@arm.com>
References: <1467308451-13365-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160703214413.GB12608@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2016 at 06:40:33PM +0100, Marc Zyngier wrote:
> Until now, we've been setting up KVM using two sets of page tables:
> one for the "boot" where we perform the basic MMU setup, and one for
> the runtime.
> 
> Switching between the two was though to be safe, but we've recently
> realized that it is not: it is not enough to ensure that the VA->PA
> mapping is consistent when switching TTBR0_EL2, but we also have to
> ensure that the intermediate translations are the same as well. If the
> TLB can return two different values for intermediate translations,
> we're screwed (TLB conflicts).
> 
> At that point, the only safe thing to do is to never change TTBR0_EL2,
> which means that we need to make the idmap page part of the runtime
> page tables.
> 
> The series starts with a bit of brain dumping explaining what we're
> trying to do. This might not be useful as a merge candidate, but it
> was useful for me to put this somewhere. It goes on revamping the
> whole notion of HYP VA range, making it runtime patchable. It then
> always merge idmap and runtime page table into one set, leading to
> quite a lot of simplification in the init/teardown code. In the
> process, 32bit KVM gains the ability to teardown the HYP page-tables
> and vectors, which makes kexec a bit closer.
> 
> This has been tested on Seattle, Juno, the FVP model (both v8.0 and
> v8.1), Cubietruck and Midway, and is based on the current
> kvmarm/queue.
> 

For the series:

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

Applied to queue, thanks!
