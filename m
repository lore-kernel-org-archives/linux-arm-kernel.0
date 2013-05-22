From: R64188@freescale.com (Jin Zhengxiong-R64188)
Date: Wed, 22 May 2013 08:59:20 +0000
Subject: [PATCH v3] tty: serial: add Freescale lpuart driver support
In-Reply-To: <CAAQ0ZWRz+byPKxMjDH3zKsc0u4bmkPO_1u6w2H4Z7nD0z8+9ig@mail.gmail.com>
References: <1368685096-13177-1-git-send-email-b35083@freescale.com>
 <20130520030523.GB25113@S2101-09.ap.freescale.net>
 <13F8657A829DAB49A2A937FD6FC10F790B3CDB85@039-SN2MPN1-012.039d.mgd.msft.net>
 <CAAQ0ZWRz+byPKxMjDH3zKsc0u4bmkPO_1u6w2H4Z7nD0z8+9ig@mail.gmail.com>
Message-ID: <13F8657A829DAB49A2A937FD6FC10F790B3CECEB@039-SN2MPN1-012.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH v3] tty: serial: add Freescale lpuart driver support
> 
> On 22 May 2013 14:40, Jin Zhengxiong-R64188 <R64188@freescale.com> wrote:
> > [Jason Jin-R64188] Reuse the same LPUART on LS-1 with the compatible
> strings 'fsl,mvf600-lpuart' is technically OK, But it will fuss the route
> map of the product Line. The general name can show that the IP is shared
> between several product lines, and the history for which SOC firstly used
> the IP is not very important. With general compatible name, We can setup
> the general dts for the shared IPs.
> >
> > That's also the case for the IPs used on Power platform, Take the IFC
> for example, this IP implemented on Power platform will also be reused
> LS-1, The compatible string is set as  "fsl,ifc", "simple-bus" but not
> the soc name on which the IP first used.
> >
> >  Another example, though a little different, the nor flash driver,
> which is used for many platform, the compatible "cfi-flash" will be more
> reasonable than the soc/board name.
> >
> > With the general name for the compatible string in the driver, if there
> is minor difference for the different implementation of the same IP, we
> can add the soc related compatible string to the driver to pass
> different .data structure for that soc.
> >
> 
> As I already said, a generic compatible string does not specify anything
> about compatibility/version, and hence it's not a good compatible for IP
> block which is possibly to be integrated on multiple SoCs with slight
> differences.
> 
> For example, if there is a new SoC mvf900 integrating the IP with
> everything compatible to the version used on mvf600,
> 
>   compatible = <fsl,mvf900-uart>, <fsl,mvf600-uart>;
>   compatible = <fsl,mvf900-uart>, <fsl,lpuart>;
> 
> which one do you think is better to tell the compatibility/version?
> 
> Shawn
[Jason Jin-R64188] For the lpuart itself, I do not think it will have different version IP. The general name is sufficient and soc related name can introduce the minor difference. If the there are update version, we can name it lpuart2.0 or something like that.

For the compatible property itself, the ePAPR described it as:
---- 
The compatible property value consists of one or more strings that define the specific programming model for the device. This list of strings should be used by a client program for device driver selection. The property value consists of a concatenated list of null terminated strings, from most specific to most general. 
----
So for the IPs especially for the peripheral IPs, the compatible just used to select the driver for the device. It should not used to describe the version information. If the version changed and the driver cannot be used for the device then another compatible strings should be used.

As I said, Another reason for the general strings used is the across platform issue, It's maybe reasonably to name the compatible strings as you recommended for the IPs share in the same SoC family. But for the IPs shared across platform, general name sound more reasonably to avoid the product line confusing. 

The compatible strings once named as you said for Power platform, but more general strings were used later as IPs shared for more SoCs.

I was wondering what's kind of strings should be used for this kind of IPs across different platforms. I added Grant Likely for comments, Thanks.

Jason 
