From: liguozhu@hisilicon.com (Kenneth Lee)
Date: Thu, 27 Aug 2015 17:50:35 +0800
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggMS81XSBu?= =?utf-8?Q?et=3A_ad?=
 =?utf-8?Q?d?= Hisilicon Network Subsystem support (config and documents)
In-Reply-To: <2543796.7JthO5WCfI@wuerfel>
References: <1439548222-231611-1-git-send-email-liguozhu@hisilicon.com>
 <1536926.jEJjsM70Lj@wuerfel>
 <161EFA05D917D0419F95C4CAEEF86C1094E95FAA@SZXEMA504-MBS.china.huawei.com>
 <2543796.7JthO5WCfI@wuerfel>
Message-ID: <20150827095035.GB26498@Turing-Arch-b>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 21, 2015 at 04:00:35PM +0200, Arnd Bergmann wrote:
> Date: Fri, 21 Aug 2015 16:00:35 +0200
> From: Arnd Bergmann <arnd@arndb.de>
> To: "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
> CC: "mark.rutland at arm.com" <mark.rutland@arm.com>,
>  "devicetree at vger.kernel.org" <devicetree@vger.kernel.org>,
>  "pawel.moll at arm.com" <pawel.moll@arm.com>, "ijc+devicetree at hellion.org.uk"
>  <ijc+devicetree@hellion.org.uk>, "catalin.marinas at arm.com"
>  <catalin.marinas@arm.com>, "will.deacon at arm.com" <will.deacon@arm.com>,
>  "linux-kernel at vger.kernel.org" <linux-kernel@vger.kernel.org>, Linuxarm
>  <linuxarm@huawei.com>, "paul.gortmaker at windriver.com"
>  <paul.gortmaker@windriver.com>, "robh+dt at kernel.org" <robh+dt@kernel.org>,
>  "galak at codeaurora.org" <galak@codeaurora.org>, "zhangfei.gao at linaro.org"
>  <zhangfei.gao@linaro.org>, "netdev at vger.kernel.org"
>  <netdev@vger.kernel.org>, "davem at davemloft.net" <davem@davemloft.net>,
>  "linux-arm-kernel at lists.infradead.org"
>  <linux-arm-kernel@lists.infradead.org>
> Subject: Re: ??: [PATCH 1/5] net: add Hisilicon Network Subsystem
>  support (config and documents)
> User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
> Message-ID: <2543796.7JthO5WCfI@wuerfel>
> 
> On Monday 17 August 2015 01:28:07 Liguozhu wrote:
> > Thanks, Arnd. 
> > 
> > Regarding the ae-name: it is the name of the Acceleration Engine. It is provided
> > by the BIOS according to the position and the feature enabled of the IP.
> > So "soc0" means it is on SoC No. 0, while "n4" means it is running on 
> >"Non-dsaf mode 4". Ideally, we should setup the rule to name it. But as I
> > said in the patchset, the IP is original designed for a bare metal solution,
> > it is worthless to export all modes and we are planning to add more mode
> > for Linux itself in the IP in future version. So I think the better way is
> > to leave it as a "name" but add more meaning in the future.
> 
> The name property is a bit awkward. The position is normally implied by
> the location of the parent device in the DT, so you should not need that
> at all and instead derive it elsewhere. You can also add strings to the
> compatible property instead of this, to signify differences in the programming
> that are based on how the IP block is used.
>  
> > Regarding the ae-opts: it is the initial value for the AE's runtime options,
> > Currently, we have only "port number" (there are 6XGE+2GE port for a DSAF AE)
> > as option. But for future version, we will add other options such as "enable
> > Spanning Tree Protocol algorithm)" and so on. 
> 
> I think these can easily be converted into an index property and boolean
> flags (present if true, absent otherwise) for additional features.
>  
> > Should I add these background to somewhere?
> 
> The binding document needs to list all supported configurations, if you
> have a string property, describe specifically what strings are allowed
> and what they mean, but better try to avoid strings altogether.
> 
> 	Arnd
> _______________________________________________
> linuxarm mailing list
> linuxarm at huawei.com
> http://rnd-openeuler.huawei.com/mailman/listinfo/linuxarm

Dear Arnd,

We are working on the new PatchSet. I describe the new design here so in case
you can tell us if we make something wrong.

So now we will keep some attributes in enthernet node like this:

	ethernet at 0{
		compatible = "hisilicon,hns-nic";
		ae-name = "dsaf1";
		port-id = <0>;
	};

ae-name is simply a name referring to the name of dsa_name in SAF node.

port-id is the index of port provided by DSAF (the accelerator). DSAF can
connect to 8 PHYs. Port 0 to 1 are both used for adminstration purpose. They
are called debug ports. 

The remaining 6 PHYs are taken according to the mode of DSAF.

In NIC mode of DSAF, all 6 PHYs are taken as ethernet ports to the CPU. The
port-id can be 2 to 7. Here is the diagram:

            +-----+---------------+
            |            CPU      |
            +-+-+-+---+-+-+-+-+-+-+
              | |     | | | | | |
	     debug       service 
             port         port
	     (0,1)       (2-7)

In Switch mode of DSAF, all 6 PHYs are taken as physical ports connect to a
LAN Switch while the CPU side assume itself have one single NIC connect to
this switch. In this case, the port-id will be 2 only.

            +-----+---------------+
            |            CPU      |
            +-+-+-+---+-+-+-+-+-+-+
              | |         | service port(2)
	     debug   +------------+
             port    |   switch   |
             (0,1)   +-+-+-+-+-+-++
                       | | | | | |
                        external
			 port


-- 
			-Kenneth(Hisilicon)
