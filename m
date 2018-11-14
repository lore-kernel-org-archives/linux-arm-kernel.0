From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 14 Nov 2018 13:47:52 +0100
Subject: [resend PATCH 1/3] pwm: mediatek: drop flag 'has_clks'
In-Reply-To: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
References: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
Message-ID: <20181114124752.GI2620@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 10:08:22AM +0800, Ryder Lee wrote:
> The flag 'has_clks' and related checks are superfluous as the CCF
> subsystem does this for you.

Both of these mechanisms aren't equivalent. While CCF can deal with
optional clocks, what the has_clks flag actually means is that the
device doesn't need a clock (or doesn't have a clock input) on the
devices where it is cleared.

So I'd actually be in favor of keeping the has_clks property because it
serves as an additional sanity check. For example if you run this driver
on an SoC that "has clocks" but if you don't list them in DT, then after
this patch the driver will happily continue without clocks, even though
it may break completely without those clocks. I've seen SoCs respond to
disabled clocks for a hardware block in different ways, in many cases an
access to any of the registers will completely hang the CPU. In other
cases it may just crash in some other way or give you some sort of
machine exception. None of those are good, and make the tiny bit of
additional code required to support the has_clks flag very attractive.

But that's just my opinion. If you prefer to throw away that safety
barrier, be my guest. But if you do, please move this functionality into
the clock framework first and then make the driver use it.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181114/ec0f0a69/attachment.sig>
