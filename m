From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 24 Apr 2015 22:23:57 -0600
Subject: [PATCH 9/9] ARM: BCM283x: Register fixed clocks for uart in the
 DT.
In-Reply-To: <87vbglwj5c.fsf@eliezer.anholt.net>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
 <1429639796-2169-10-git-send-email-eric@anholt.net>
 <5539CA1A.1040009@wwwdotorg.org> <87vbglwj5c.fsf@eliezer.anholt.net>
Message-ID: <553B16DD.9090507@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2015 11:06 AM, Eric Anholt wrote:
> Stephen Warren <swarren@wwwdotorg.org> writes:
> 
>> On 04/21/2015 12:09 PM, Eric Anholt wrote:
>>> We were previously relying on the fixed clock registration in 
>>> clk-bcm2835, but there doesn't seem to be any real reason to
>>> not just define it in the DT (and for the 2836 port, I would
>>> have needed to change the clock's physical address in
>>> clk-bcm2835.c).  Also, because we weren't registering the
>>> apb_pclk in clk-bcm2835 as a clock device, we were picking up
>>> the uart clock node as apb_pclk by accident.
>> 
>> Doesn't the following do just that?
>> 
>> clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL,
>> CLK_IS_ROOT, 126000000);
> 
> Nope!  You also need the clk_register_clkdev for the type of
> lookup being done by APB to find it.

Oh right, that just creates a clock object without registering it in
the lookup table?

>> Anyway, with this patch, shouldn't we fix
>> drivers/clk/clk-bcm2835.c not to register clocks that match those
>> that are added to DT in this patch? Actually, to maintain DT ABI
>> (new kernels working with old or new DT), we probably need to
>> keep the code in clk-bcm2835.c, but make it conditional upon
>> whether there's a clock node in the DT file.
> 
> Yeah, I hadn't modified the .c code because of DT ABI

Should the C file be modified not the create those clock objects if
the DT contains them?
