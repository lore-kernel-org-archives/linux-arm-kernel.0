From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jul 2014 16:35:29 +0200
Subject: [Patch V2 2/2] i2c: mv64xxx: Remove internal compatible string
 from Documentation
In-Reply-To: <20140728141217.GE2891@lunn.ch>
References: <1406395238-29758-1-git-send-email-andrew@lunn.ch>
 <5514427.elClhaDPhf@wuerfel> <20140728141217.GE2891@lunn.ch>
Message-ID: <6346429.sjQYojn1ot@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 July 2014 16:12:17 Andrew Lunn wrote:
> > 
> > I remember this being discussed when the quirk was initially added,
> > but it seemed cleaner to handle this in the platform code at the time
> > when it was just for one particular board. Now that it's basically
> > an accepted feature of the i2c device that you have to know the
> > SoC version, that should probably become a proper API.
> > 
> > Also, we now have drivers/soc/ and can move the soc-id code there
> > with a publically documented API.
> 
> Getting the SoC ID and revision seems like something that should be
> generic. Would it be better to make this part of drivers/base/soc.c?
> mvebu already does a soc_device_register() with the relevant
> information.
> 
> Add a call something like:
> 
> /*
>  * Return the soc device attributes for a given soc_dev. If soc_dev is NULL,
>  * the first device on the soc bus is returned.
>  */
> struct soc_device_attribute *soc_attribute_get(struct soc_device * soc_dev);

Interesting idea, yes.

There could also be a higher-level function that does a strcmp() in addition,
so that a driver can do some variation of

	if (soc_name_is("Armada XP") && soc_revision_is("A0"))
		...

	Arnd
