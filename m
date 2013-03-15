From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Mar 2013 17:12:00 +0000
Subject: [RFC 1/1] clk: Add notifier support in
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <5142B027.4040403@wwwdotorg.org>
References: <1363151317.3311.9.camel@bilhuang-vm1>
 <51400D9D.9060305@wwwdotorg.org> <1363153204.3311.14.camel@bilhuang-vm1>
 <5140C12A.4060900@wwwdotorg.org> <1363227311.3311.30.camel@bilhuang-vm1>
 <20130314092132.GE18519@tbergstrom-lnx.Nvidia.com>
 <1363253287.3311.32.camel@bilhuang-vm1> <51420EBB.7080503@wwwdotorg.org>
 <1363310454.3311.44.camel@bilhuang-vm1> <5142B027.4040403@wwwdotorg.org>
Message-ID: <20130315171200.GN4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 11:22:47PM -0600, Stephen Warren wrote:
> Is clk_set_rate() only legal to call in non-atomic contexts then? The
> header file doesn't say, although I guess since many other functions
> explicitly say they can't, then by omission it can...

I think when all this was discussed alongside the clk_prepare/clk_unprepare
stuff, that yes, it was decided that clk_set_rate() was non-atomic only.

And yes, that is most definitely the case, because the first thing 
clk_set_rate() does is take a mutex - which will trigger a might_sleep()
complaint if ever called from an atomic context.
