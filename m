From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 3 Oct 2011 11:34:34 -0600 (MDT)
Subject: [PATCH v2] OMAP2PLUS: DSS: Ensure DSS works correctly if display
	is enabled in bootloader
In-Reply-To: <4E898468.2060508@ti.com>
References: <1315811306-11001-1-git-send-email-archit@ti.com>
	<alpine.DEB.2.00.1110022237171.4611@utopia.booyaka.com>
	<1317630070.2026.27.camel@deskari> <4E898468.2060508@ti.com>
Message-ID: <alpine.DEB.2.00.1110031126090.4611@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ devicetree-discuss, lkml

On Mon, 3 Oct 2011, Cousson, Benoit wrote:

> But at that time, device tree was not there...
> Now, the whole dev_attr stuff will be replaced because device tree is able to
> provide the driver any kind of custom information that can be retrieved
> directly from the driver without having to use a pdata in between. So I'm not
> sure it worth spending too much time on that feature stuff.
> 
> As an example here is the ongoing GPIO DT migration:
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg56505.html
> 
> 3.2 will have the basic DT support using hwmod as a backend, but the idea is
> that for 3.3, we start removing some information from hwmod to rely on device
> tree only.

One comment here though -- and I will make this comment on the original 
series too -- is that we should avoid adding direct DT dependencies into 
the driver.

Specifically, these of_get_property() and of_property*() calls in the 
driver aren't right.

We need some way of doing this that is completely independent from the 
device data format.  Some way that does not care whether the input data is 
coming from DT, platform_data, ACPI, or whatever the new flavor of the 
year will be next year.  Or we need to declare that these of_*() calls are 
not DT-specific, and define them as hooks that the device data format code 
can handle as it pleases.

Otherwise we'll need shim layers for each new data format in the driver 
code and that will be a huge and unnecessary mess.


- Paul
