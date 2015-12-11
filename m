From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 11 Dec 2015 14:11:43 -0800
Subject: [PATCH v4 01/58] mtd: nand: denali: add missing nand_release()
 call in denali_remove()
In-Reply-To: <20151211230305.506e2071@bbrezillon>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
 <1449734442-18672-2-git-send-email-boris.brezillon@free-electrons.com>
 <20151211004008.GQ144338@google.com>
 <20151211230305.506e2071@bbrezillon>
Message-ID: <20151211221143.GR144338@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Fri, Dec 11, 2015 at 11:03:05PM +0100, Boris Brezillon wrote:
> On Thu, 10 Dec 2015 16:40:08 -0800
> Brian Norris <computersforpeace@gmail.com> wrote:
> > On Thu, Dec 10, 2015 at 08:59:45AM +0100, Boris Brezillon wrote:
> > > Unregister the NAND device from the NAND subsystem when removing a denali
> > > NAND controller, otherwise the MTD attached to the NAND device is still
> > > exposed by the MTD layer, and accesses to this device will likely crash
> > > the system.
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > Cc: <stable@vger.kernel.org> #3.8+
> > 
> > Does this follow these rules, from
> > Documentation/stable_kernel_rules.txt?
> > 
> >  - It must be obviously correct and tested.
> > 
> >  - It must fix a real bug that bothers people (not a, "This could be a
> >    problem..." type thing).
> 
> Sorry to bring the "stable or not stable (that is the question :-))"
> debate back, but after thinking a bit more about the implications of
> this missing nand_release() call, I think it is worth backporting the
> fix to all stable kernels.
> The reason is, it can potentially introduce a security hole, because if
> the mtd device is not unregister but the underlying mtd object is freed
> and the kernel reuses the same memory region for a different object,
> the MTD layer will possibly call one of the mtd->_method() function,
> and this field might point to another completely different function.
> 
> You'll say that denali devices are probably never removed and this is
> the reason why people have never seen this problem before, which would
> be a good reason to not bother backporting the patch.
> But, given that the driver can be compiled as a module (the user can
> possibly load/unload it, which will in turn create/destroy the
> NAND/MTD device), and that the denali controller can be exposed through
> a PCI bus (which, AFAIK is hotpluggable), I really think this fix
> should be sent to stable.

That's all well and good, but still nobody has told me they've tested
this.

I've pushed your v5 (+ comments, + ack) to l2-mtd.git. If it gets
testing and this request is made again at that point, we can easily send
it to stable after it hits Linus' tree. See option 2 in
Documentation/stable_kernel_rules.txt. You can even send the email
yourself, just CC me and anyone else relevant. I'll ack it if it's been
tested.

Regards,
Brian
