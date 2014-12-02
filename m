From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 2 Dec 2014 14:29:43 +0100
Subject: [PATCH 5/5] arm/arm64: KVM: Turn off vcpus and flush stage-2
 pgtables on sytem exit events
In-Reply-To: <CAFEAcA9kq=Fvhbc5+bTavb1KiaEn6+JYf=c6MaZYihbu_gT9sg@mail.gmail.com>
References: <1417113660-23610-1-git-send-email-christoffer.dall@linaro.org>
 <1417113660-23610-6-git-send-email-christoffer.dall@linaro.org>
 <CAFEAcA9hRvaWZiXOjTQP3+4B+r7h7W7oqRm6y=cxw+EJKNk-0w@mail.gmail.com>
 <CAFEAcA9kq=Fvhbc5+bTavb1KiaEn6+JYf=c6MaZYihbu_gT9sg@mail.gmail.com>
Message-ID: <20141202132943.GF545@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 05:57:53PM +0000, Peter Maydell wrote:
> On 27 November 2014 at 23:10, Peter Maydell <peter.maydell@linaro.org> wrote:
> > It seems odd to have this unmap happen on attempted system reset/powerdown,
> > not on cpu init/start.
> 
> Here's a concrete case that I think requires the unmap to be
> done on cpu init:
>  * start a VM and run it for a bit
>  * from the QEMU monitor, use "loadvm" to load a VM snapshot
> 
> This will cause QEMU to do a system reset (including calling
> VCPU_INIT to reset the CPUs), load the contents of guest
> RAM from the snapshot, set guest CPU registers with a pile
> of SET_ONE_REG calls, and then KVM_RUN to start the VM.
> 
> If we don't unmap stage2 on vcpu init,  then what in this
> sequence causes the icaches to be flushed so we execute
> the newly loaded ram contents rather than stale data
> from the first VM run?
> 

You're absolutely right that it makes more sense to stick it in
vcpu_init.  I put it only in the shutdown event handler for debugging
and forgot that was what I was doing :)

The only down-side is that we'll be trying to free memory that was never
mapped on initial startup, but it's not in the critical path and we
could add an explicit check to early-out if the vcpu has never been run,
which may increase code readibility too (we already have that flag I
belive).

-Christoffer
