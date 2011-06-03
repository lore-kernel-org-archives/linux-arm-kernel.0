From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 3 Jun 2011 08:55:58 -0600
Subject: [PATCH v2 0/4] Move plat-mxc gpio driver into drivers/gpio
In-Reply-To: <20110603143406.GA19344@S2100-06.ap.freescale.net>
References: <1306985632-18820-1-git-send-email-shawn.guo@linaro.org>
	<20110603075201.GE10532@n2100.arm.linux.org.uk>
	<20110603143406.GA19344@S2100-06.ap.freescale.net>
Message-ID: <BANLkTi=5kNAt51DP3-rykkT3ZONczD5Crg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 3, 2011 at 8:34 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> Hi Russell,
>
> On Fri, Jun 03, 2011 at 08:52:01AM +0100, Russell King - ARM Linux wrote:
>> On Thu, Jun 02, 2011 at 11:33:48AM +0800, Shawn Guo wrote:
>> > ?arch/arm/plat-mxc/gpio.c ? ? ? ? ? ? ? ? ? ? ? ?| ?361 -------------------
>> > ?drivers/gpio/gpio-mxc.c ? ? ? ? ? ? ? ? ? ? ? ? | ?433 +++++++++++++++++++++++
>>
> My bad here. ?I should have used 'git diff --stat -M' to show the
> the following.
>
> .../arm/plat-mxc/gpio.c => drivers/gpio/gpio-mxc.c | ?216 +++++++++++++-------
>
>> I'm wondering why just moving this driver into drivers/gpio has
>> resulted in it growing by 72 lines - and it's not clear from the
>> diffs why that is because of the way they're broken up.
>>
> Yes, I agree. ?But when I did something like that to ease the review,
> people think it's not necessary :)
>
> http://permalink.gmane.org/gmane.linux.kernel/1143257

The issue was bisectability: it looked like the build would break
after applying the first patch.  The first patch should move the
driver without breaking the build, and then you can follow up with
driver fixes.  I don't want to see functional changes mixed in with
the file move change.

> +
> +static struct platform_driver mxc_gpio_driver = {
> + ? ? ? .driver ? ? ? ? = {
> + ? ? ? ? ? ? ? .name ? = "gpio-mxc",

.owner = THIS_MODULE,

g.
