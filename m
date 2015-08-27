From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Aug 2015 15:45:49 +0100
Subject: [PATCH] arm64: KVM: Do not inject a 64bit fault for a 32bit guest
In-Reply-To: <1440684348-5292-1-git-send-email-marc.zyngier@arm.com>
References: <1440684348-5292-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150827144549.GF21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 27, 2015 at 03:05:47PM +0100, Marc Zyngier wrote:
> When injecting a fault into a 32bit guest, it seems rather idiotic
> to also inject a 64bit fault that is only going to corrupt the
> guest state, and lead to a situation where we restore an illegal
> context.
> 
> Just fix the stupid bug that has been there from day 1.
> 
> Cc: stable at vger.kernel.org
> Reported-by: Russell King <linux@arm.linux.org.uk>

s/linux/rmk+kernel/ please

Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> Will: Paolo being on holiday, do you mind merging this one
> via your tree?

I don't think the commit message does this bug justice.  The implication
is it's just a guest issue.  It isn't, the bug appears to take out the
host kernel in a truely spectacular way.

http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=4871

Tested here, the fix stops the host kernel exploding.  The crashed kvm
instance can be stopped and a proper kernel can then be booted in a new
guest instance.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
