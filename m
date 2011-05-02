From: robherring2@gmail.com (Rob Herring)
Date: Mon, 02 May 2011 11:30:10 -0500
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <1304307632.2686.33.camel@pororo>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>	
	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>	
	<4DBDC3B5.7070808@gmail.com> <1304298586.2686.29.camel@pororo>	
	<4DBE2064.2060303@gmail.com> <1304307632.2686.33.camel@pororo>
Message-ID: <4DBEDC12.4090203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/2011 10:40 PM, Jeremy Kerr wrote:
> Hi Rob,
>
>> I think you will find many examples in the kernel where that is not done
>> by drivers.
>
> Drivers should be checking the return value of clk_get - if they don't,
> it's a bug. This is the logical place to check, rather than before all
> clock API calls.

Maybe so, but it's common practice. Why not allow it, but add a warning? 
Or allow NULL, but not an error value.

> For cases where there is no clock provided for the device (but is a
> valid clock on some machines), the platform code should return a no-op
> clock from the clk_get call. This 'noop clock' would be a good contender
> for inclusion into the kernel-wide infrastructure, like clk_fixed.
>

There could be cases where the driver wants to know if there is no 
clock. A cpufreq driver for example would be pointless to register if no 
clock is available. Making the every platform clk_get code have to 
handle the 2 cases would require the platform code to know what the 
driver wants. Also, it would require at least some platform clock code 
to enable a new platform if you have existing drivers with both cases.

You could do something like this:

clk = clk_get(mydev, NULL);
if (IS_ERR(clk))
	clk = noop_clk;

Or add a variation of clk_get like clk_get_or_fail where clk_get returns 
noop clk and clk_get_or_fail returns nothing if the clock is not found.

Rob
