From: robherring2@gmail.com (Rob Herring)
Date: Tue, 10 Apr 2012 08:36:56 -0500
Subject: COMMON_CLK_DISABLE_UNUSED
In-Reply-To: <CAJOA=zP8XFTN1mcAyUky3ovrx4Dg1zb9zaB5r8zUYE46Ec-tMQ@mail.gmail.com>
References: <20120409222903.GA31622@lunn.ch>
 <CAJOA=zP8XFTN1mcAyUky3ovrx4Dg1zb9zaB5r8zUYE46Ec-tMQ@mail.gmail.com>
Message-ID: <4F843778.8050506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2012 06:04 PM, Turquette, Mike wrote:
> On Mon, Apr 9, 2012 at 3:29 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> I think it would be good to consider deleting this config option and
>> just have the code always enabled.
> 
> I agree.  We already support the CLK_IGNORE_UNUSED flag, so any
> platforms that don't want this functionality wholesale can set that
> bit for every clock.
> 
> I'll pull out that option.
> 

CLK_IGNORE_UNUSED looks a bit broken to me. If you don't have the flag
set on the whole chain of parents, then a parent could be turned off.
This could happen at boot time or when another child get disabled and
the common parent's ref count goes to 0 and gets disabled.

I think a better solution would be a force enable or enable on boot flag
that sets ref counts correctly. Otherwise, each platform has to call
clk_prepare and clk_enable for all the clocks it wants to keep on.

Here's a simple case that needs work. You have a cpu clock controlled by
cpufreq driver. If the cpufreq driver is not loaded, we want the cpu
clock always enabled and don't want the clk infrastructure turning it
off. If the cpufreq driver is loaded, then we potentially want it to be
able to enable and disable the cpu clock if we switch parents. I guess
the easiest solution is the cpufreq driver needs to assume the cpu clock
is already enabled with a ref count of 1.

Rob
