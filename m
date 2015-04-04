From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 04 Apr 2015 13:06:23 +0200
Subject: [PATCH] sunxi: a10-lime: add regulator nodes
In-Reply-To: <551FBD45.3060503@gmail.com>
References: <551537ED.7060402@gmail.com> <551538AB.50207@redhat.com>
 <55169622.5070007@gmail.com> <20150330222311.GY23664@lukather>
 <551FBD45.3060503@gmail.com>
Message-ID: <551FC5AF.3040601@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04-04-15 12:30, Iain Paton wrote:
> On 30/03/15 23:23, Maxime Ripard wrote:
>
>> CSI is not usable (no driver for it), neither it is actually used by
>> default on the lime, so disabling the regulator is the right thing to
>> do.
>
> My userspace code works just fine, until the regulator gets turned off.

So you've userspace code to use the csi interface? Cool! Any chance you
can publish this somewhere. I've writing v4l2 drivers for the csi
on the sunxi SoCs somewhere (low) on my todo list.

> Anyway, I don't have the patience Hans showed with the simplefb stuff.
> So consider yourselves successful in wearing me down. I'm done debating
> any of this. One less contributor to linux-sunxi for you to worry about,
> I won't bother you anymore.

I'm sorry to hear that, it would have helped tremendously here if
you had explained that you actually have a camera sensor hooked up
and are using that with an upstream kernel right from the start.

As I've hopefully shown when merging your u-boot patches we certainly
welcome you as a contributor, and I do hope you will keep contributing
in the future.

As for this specific patch I'm still of the opinion that your original
patch is not the right way forward, we are using axp209.dtsi with all
new boards and we are slowly moving existing boards over too.

Note that it is only a matter of time until someone does submit
a patch which follows the standard way of doing things for sunxi
boards and then your camera sensors will stop working.

Recent kernel support something known as devicetree overlays which
I believe is the way forward with this, what we would like to see
for cases like this one is to have a patch in the main dts which
works as Maxime and I requested, and then use a dts overlay to
enable ldo3 and ldo4 for your specific situation. This solution
should also be future proof, since as said someone will make the
requested changes eventually as we plan to move all boards to
using axp209.dtsi and not enabling unnecessary regulators.

You will likely object to me labeling the ldo3 and ldo4 regulators
as unnecessary but think this through for a moment Olimex has
sold thousands of lime boards, how much of those do you think
will have camera sensors attached? For the default upstream
dts file we need to do what is right for the normal / default
use case here. And for people who have special hardware /
daughtboards attached that is exactly what devicetree overlays
are designed to handle.

Regards,

Hans




>
>> Too bad.
>
> For who?
>
> Rgds,
> Iain
>
