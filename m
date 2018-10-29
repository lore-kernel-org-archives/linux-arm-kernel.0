From: lsun@mellanox.com (Liming Sun)
Date: Mon, 29 Oct 2018 16:09:07 +0000
Subject: [PATCH v4 2/4] arm64: Add Mellanox BlueField SoC config option
In-Reply-To: <CAK8P3a2_0mYaJ0NjWSMxpmoF9+tcoHtfhJQJ0Aj9Tds+f7KuEg@mail.gmail.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1540403734-137721-1-git-send-email-lsun@mellanox.com>
 <1540403734-137721-2-git-send-email-lsun@mellanox.com>
 <CAK8P3a1jTsvzYhS4CxvmK6tOgPn_g7=1S4xAcca2K4v70vhyEA@mail.gmail.com>
 <AM4PR05MB32204021433BBB853C50FF30A1F00@AM4PR05MB3220.eurprd05.prod.outlook.com>
 <CAK8P3a2=shWVjwrmnNTwwGwN_jhwyb+TmeALz4zzTstho51z8A@mail.gmail.com>
 <DB6PR05MB32236AAD033C20DF6414C464A1F30@DB6PR05MB3223.eurprd05.prod.outlook.com>
 <CAK8P3a2_0mYaJ0NjWSMxpmoF9+tcoHtfhJQJ0Aj9Tds+f7KuEg@mail.gmail.com>
Message-ID: <DB6PR05MB32237D37B4A36453C83FC9BAA1F30@DB6PR05MB3223.eurprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please see my response below.

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Monday, October 29, 2018 11:26 AM
> To: Liming Sun <lsun@mellanox.com>
> Cc: Olof Johansson <olof@lixom.net>; David Woods
> <dwoods@mellanox.com>; Robin Murphy <robin.murphy@arm.com>; arm-
> soc <arm@kernel.org>; DTML <devicetree@vger.kernel.org>; Linux ARM
> <linux-arm-kernel@lists.infradead.org>
> Subject: Re: [PATCH v4 2/4] arm64: Add Mellanox BlueField SoC config option
> 
> On Mon, Oct 29, 2018 at 3:58 PM Liming Sun <lsun@mellanox.com> wrote:
> > > It would be nice if you could still include the dts sources in the submission.
> > > Since this is not a classic server hardware, DT is probably more suitable
> > > here, and there are likely use cases that won't work with ACPI, so it's
> > > good to have a starting point for your users if they need to override
> > > the ACPI tables with a DT, or build systems with a simpler boot loader.
> >
> > Sure, I'll keep this DT change for reference. A little explanation that
> > Mellanox BlueField SOC could be PCIe NIC or standalone device (server)
> form which
> > can do PXE boot, CentOS installation even on the NIC, etc. The same
> software/driver
> > works on both.
> 
> Ok, good.
> 
> >  DT seems not working well for some requirement/features like
> > NVDIMM (which requires ACPI DSM).  That's why we switched to ACPI
> though
> > DT support is preserved.
> 
> This is probably something we need to look at separately, I'm sure we will
> want
> to use NVDIMM with DT based systems in the future. Can you explain what
> the DSM is used for here? Is this something that could be done in software
> in the NVDIMM hardware specific driver?

The DSM is kind of running logic instead of configuration which is provided by 
system firmware. It's defined in the UEFI spec and supported by Linux. In the
NVDIMM case here, it's used to do Address Range Scrub (ARS), I2C access (such as
reading the DIMM SPD information), runtime health check, etc. 

DSM is kind of requirement by NVDIMM, such as
https://pmem.io/documents/NVDIMM_DSM_Interface_Example.pdf
https://docs.microsoft.com/en-us/windows-hardware/drivers/storage/-dsm-interface-for-byte-addressable-energy-backed-function-class--function-interface-1-

By following the ACPI DSM definitions, there is no extra drivers needed in 
Linux due to the existing ACPI framework.  Since it's 'standard' APIs in UEFI, 
it has potential to support other OS other than Linux.

Hardware specific driver might be able to do some of the functionality, or
even 'simulate' some of the ACPI implementation or APIs. I guess it might need 
a framework for it which I haven't thought a lot of details yet :)

> 
>        Arnd
