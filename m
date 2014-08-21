From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Aug 2014 09:27:41 +0100
Subject: [RFC PATCH] arm: fix get_user BE behavior for target variable
 with size of 8 bytes
In-Reply-To: <1408598949-23050-1-git-send-email-victor.kamensky@linaro.org>
References: <1408598949-23050-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140821082740.GI30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 20, 2014 at 10:29:09PM -0700, Victor Kamensky wrote:
> e38361d 'ARM: 8091/2: add get_user() support for 8 byte types' commit
> broke V7 BE get_user call when target var size is 64 bit, but '*ptr' size
> is 32 bit or smaller. e38361d changed type of __r2 from 'register
> unsigned long' to 'register typeof(x) __r2 asm("r2")' i.e before the change
> even when target variable size was 64 bit, __r2 was still 32 bit.
> But after e38361d commit, for target var of 64 bit size, __r2 became 64
> bit and now it should occupy 2 registers r2, and r3. The issue in BE case
> that r3 register is least significant word of __r2 and r2 register is most
> significant word of __r2. But __get_user_4 still copies result into r2 (most
> significant word of __r2). Subsequent code copies from __r2 into x, but
> for situation described it will pick up only garbage from r3 register.
> 
> It was discovered during 3.17-rc1 V7 BE KVM testing. Simple test case below.
> Note it works in LE case because r2 in LE case is still least significant
> word.
> 
> Proposed fix uninspiringly restores previous code but now in individual
> branches of switch statement for '*(__p)' byte sizes 1, 2, 4 and have
> newer code only for sizeof(*(__p)) == 8. Looking for may be better ideas
> how to fix the issue.

The only down side of this is that it quadruples the number of warnings
when get_user() is used incorrectly:

t-getuser.c: In function ?test_wrong?:
t-getuser.c:346:388: warning: assignment discards ?const? qualifier from pointer target type [enabled by default]
t-getuser.c:346:581: warning: assignment discards ?const? qualifier from pointer target type [enabled by default]
t-getuser.c:346:774: warning: assignment discards ?const? qualifier from pointer target type [enabled by default]
t-getuser.c:346:1100: warning: assignment discards ?const? qualifier from pointer target type [enabled by default]

as we now have four assignments instead of one.  It would be nice to have
proper behaviour here, with just one warning.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
