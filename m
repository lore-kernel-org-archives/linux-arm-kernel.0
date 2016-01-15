From: cmetcalf@ezchip.com (Chris Metcalf)
Date: Fri, 15 Jan 2016 15:02:48 -0500
Subject: [PATCH] help guest boot up on AArch64 host with GICv2
Message-ID: <56995068.9050207@ezchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are using GICv2 compatibility mode in the Fast Models/Foundation 
Models simulations we are running because the boot code (ATF/UEFI) 
doesn't support GICv3 in our system at the moment.

However, starting with kernel 4.2, the guest couldn't boot up because it 
wasn't getting timer interrupts.  I tracked this down to a kernel commit 
that switched to using the "alternatives" mechanism -- rather than 
seeing either a GICv2 or GICv3 and configuring appropriately, the KVM 
code just configured the code that saves/restores the vgic state based 
on the presence of the system register interface to the GIC CPU 
interface.  See the attached patch for a fix that manages this 
differently and allows me to boot up the guest in this configuration.

However, even assuming this patch can be taken into an upstream tree, I 
still have a couple of additional problems:

- I can boot up with the Foundation Models using this change, but not 
with the Fast Models (again, using a v3 GIC but in v2 compatibility mode 
in the device tree).  The Fast Models dts looks like it has the same 
configuration for the GIC and the timers so I'm not sure what's going on 
here.  Any suggestions appreciated.

- Without this change, I could only boot kernels up to 4.1.  With the 
change, I can boot kernels up to 4.3.  But 4.4 won't boot for me either; 
I haven't bisected it down yet.  So any suggestions on what might be 
going wrong here would also be appreciated.

We are planning to eventually use GICv3 mode in our software stack but 
for the time being I assume it is interesting to resolve issues with GIC 
v2 compatibility mode on GIC v3.

-- 
Chris Metcalf, EZChip Semiconductor
http://www.ezchip.com

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-gic-update-save-restore-pointers-only-when-gic-v3-de.patch
Type: text/x-patch
Size: 4775 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160115/51d99c9a/attachment.bin>
