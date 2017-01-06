From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Fri, 6 Jan 2017 01:17:21 +0000
Subject: [PATCH v2 9/9] ARM: sunxi: Convert pinctrl nodes to generic
 bindings
In-Reply-To: <20170105153556.pzec5jjuz7pmvsmn@lukather>
References: <cover.7edc6c25be8a5e2efdda6a82e102dbf7ece6aa64.1476200742.git-series.maxime.ripard@free-electrons.com>
 <e32d044d2d967f24f12d83eea50e7f14f2ae1073.1476200742.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v67_4iriM2WS33hUWzNZY8R2WvGjqzntGBPGmNkr1Ryr_w@mail.gmail.com>
 <58723369-50ad-1792-9be1-c277eb719044@arm.com>
 <20170105153556.pzec5jjuz7pmvsmn@lukather>
Message-ID: <dfd7242d-6b16-6091-979f-0bff85a20806@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/17 15:35, Maxime Ripard wrote:

Hi Maxime,

> On Wed, Jan 04, 2017 at 02:16:23AM +0000, Andr? Przywara wrote:
>> So can I ask that we start taking this seriously and stop doing things
>> which prevent Allwinner boards from being supported properly?
>> Which would first involve dropping this very patch?
> 
> The driver still supports the old binding.

Yes, a _current_ version of the driver supports both bindings, but older
versions *require* the older binding and bail out if various
allwinner,xxx properties are missing - as in those proposed new DTs:

4.9 kernel with sunxi/for-next .dtb:
sun8i-h3-pinctrl 1c20800.pinctrl: missing allwinner,function property in
node uart0
sun8i-h3-pinctrl 1c20800.pinctrl: missing allwinner,function property in
node mmc0
sunxi-mmc: probe of 1c0f000.mmc failed with error -22

>> Having done breakage in the past (with "allwinner,sun7i-a20-mmc", for
>> instance) is no excuse for doing it again.
> 
> I'm not sure which breakage we introduced with a new compatible: the
> old compatible is working just like it used to, and the new one is
> working like we need it to.

But the new compatible is not recognized with older kernels, preventing
people from using the newest DT with older kernels as well.
I proposed to simply work around this by using the old compatible as a
fallback: compatible="sun7i-a20-mmc", "sun5i-a13-mmc";
Unfortunately this suggestion was not followed.
So now we can't boot a 4.8 (or earlier) kernel with a .dtb from a 4.9 or
later tree. Adding the extra string would fix this.

Actually the recommended approach to avoid this situation in the first
place is to always use compatible strings with the SoC-specific name as
the first string, followed by the compatible string the driver works
with. And this should be done upon introducing a new DT to the tree -
even if at this point the driver doesn't deal with the new string.
Unknown strings will just be skipped.
So for instance the H5 DT should read: "sun50i-h5-mmc",
"sun50i-a64-mmc", "sun5i-a13-mmc"; (with the last string possibly being
optional). The current kernel driver will not match the h5 string, so it
falls back to the a64 string and works. If we learn about a neat eMMC
5.1 feature (or any quirk the H5 can benefit from) somewhere in the
future, we can add the code together with this h5 string to the driver
and don't need to change the DT at all.

>> And especially I want to avoid this habit creeping into the arm64
>> world (thinking about the H5 here, which may be impacted by this
>> very patch, for instance).
> 
> And again, if you looked at the entire serie, you would have seen that
> I took this into account.

I saw that and I appreciate that very much, but that post was not about
keeping compatibility with older DTs, but allowing older kernels to run
with the latest DT as well.
Newer DTs from your -next branch do not work with older kernels - that
is what my whole post was about. _Why_ we should care is explained there.

And please don't get me wrong: I am not asking for rewriting and bending
the whole kernel source to make this possible, it's just that we drop
this patch here, for instance, or simply not _change_ compatible names,
but instead add new strings.

Cheers,
Andre.
