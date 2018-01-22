From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Jan 2018 12:08:59 +0100
Subject: [PATCH 1/6] mfd: syscon: Add syscon_register() function
In-Reply-To: <75ad5a5e-319e-75d3-c1c7-15e7518d424b@ti.com>
References: <1516418424-28686-1-git-send-email-david@lechnology.com>
 <1516418424-28686-2-git-send-email-david@lechnology.com>
 <75ad5a5e-319e-75d3-c1c7-15e7518d424b@ti.com>
Message-ID: <CAK8P3a1AP1sz3nT8S6WMupo3iSVRsn2t9sPg2Mj1RAY1AS58UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 22, 2018 at 11:53 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> On Saturday 20 January 2018 08:50 AM, David Lechner wrote:
>> This adds a new syscon_register() function that creates a new syscon
>> regmap and adds it to the lookup list.
>
> /*
>  * registers a "global" syscon "device", usually not backed by a real
>  * device. To be used only in cases where the syscon is not
>  * related to any actual device, like system clocks, for example.
>  *
>  * name passed here must be globally unique.
>  */
> struct regmap *syscon_register_by_name(resource_size_t start, size_t
>                                        size, const char *name);
>
> and
>
> struct regmap *syscon_regmap_lookup_by_name(const char *name);
>
> I understand, with this the driver becomes little more complicated and
> DT and non-DT cases still need to be handled differently. But I think
> thats not the main issue you are trying to solve.

I think the easiest way to handle this in traditional board files is to use
a platform_data structure: when the platform registers the syscon,
it holds a pointer to the regmap and can simply add pass it to any
device using the syscon through platform_data. The driver using it
then does:

if (dev->of_node) {
      priv->regmap = syscon_regmap_lookup_by_phandle(...);
else
      priv->regmap = pdata->regmap;

At some point, we had a syscon_regmap_lookup_by_pdevname()
that was introduced for a similar case, but we should just kill that
now, after the platform that needed it is DT-only.

       Arnd
