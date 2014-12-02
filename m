From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 2 Dec 2014 15:47:45 +0100
Subject: [PATCH 0/5] Improve PSCI system events and fix reboot bugs
In-Reply-To: <20141201133411.GA5953@hawk.usersys.redhat.com>
References: <1417113660-23610-1-git-send-email-christoffer.dall@linaro.org>
 <20141201133411.GA5953@hawk.usersys.redhat.com>
Message-ID: <20141202144745.GI545@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 02:34:12PM +0100, Andrew Jones wrote:
> On Thu, Nov 27, 2014 at 07:40:55PM +0100, Christoffer Dall wrote:
> > Several people have reported problems with rebooting ARM VMs, especially
> > on 32-bit ARM.  This is mainly due to the same reason we were seeing
> > boot errors in the past, namely that the ram, dcache, and icache weren't
> > coherent on guest boot with the guest (stage-1) MMU disabled.  We solved
> > this by ensuring coherency when we fault in pages, but since most memory
> > is already mapped after a reboot, we don't do anything.
> > 
> > The solution is to unmap the regular RAM on system events, but we must
> > take care to not unmap the GIC or other IO regions, hence the somehwat
> > complicated solution.
> > 
> > As part of figuring this out, it became clear that some semantics around
> > the KVM_ARM_VCPU_INIT ABI and system event ABI was unclear (what is
> > userspace expected to do when it receives a system event).  This series
> > also clarifies the ABI and changes the kernel functionality to do what
> > userspace expects (turn off VCPUs on a system shutdown event).
> > 
> > The code is avaliable here as well:
> > http://git.linaro.org/people/christoffer.dall/linux-kvm-arm.git vcpu_init_fixes
> > 
> > There is an alternative version with more code reuse for what is patch 4
> > in this series available here:
> > http://git.linaro.org/people/christoffer.dall/linux-kvm-arm.git vcpu_init_fixes-alternative
> > 
> > See patch 4 for more info on this one.
> > 
> > Testing
> > -------
> > This has been tested on CubieBoard, Arndale, TC2, and Juno.  On Arndale
> > and TC2 it was extremely easy to reproduce the setup (just start a VM
> > that runs reboot from /etc/rc.local or similar) and this series clearly
> > fixes the behavior.
> 
> We've also seen reboots leading to a stuck vcpu. It appeared to be 100%
> reproducible on a freshly installed guest (first reboot after running
> the installer), and then intermittently afterwards. I've just tested
> this patch series, and it appears to resolve the issue. No stuck vcpu
> after install, and a reboot loop has been running for a while now. I'm
> testing on a mustang. If you like, feel free to add a
> 
> Tested-by: Andrew Jones <drjones@redhat.com>
> 
Thanks!
-Christoffer
