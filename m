From: oss@buserror.net (Scott Wood)
Date: Mon, 03 Sep 2018 15:33:33 -0500
Subject: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for lx2160a
In-Reply-To: <DB5PR0401MB221332A5ED14C8E14C8D18A1F30C0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
 <4a9ea6b451683ec98c92e86a5ae6b91213a6afcf.camel@buserror.net>
 <VI1PR04MB4800E8B1E8541FCA9221A1CFF3080@VI1PR04MB4800.eurprd04.prod.outlook.com>
 <d2cfd49eb33a3ce74f0e78f2b53d3954d2cb3e76.camel@buserror.net>
 <b31ae8e788fb93971167faa9b55b497e838532c4.camel@buserror.net>
 <DB5PR0401MB22130C025AA4CCAD0221781DF30F0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
 <f6707cb54c3e6da1b50f45f915c996dfccfeacda.camel@buserror.net>
 <DB5PR0401MB221332A5ED14C8E14C8D18A1F30C0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
Message-ID: <3a4274af2200923875ff05f945888a34d6dccee3.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-09-03 at 01:17 +0000, Andy Tang wrote:
> Hi Scott,
> 
> Please see my replay in line.
> 
> > -----Original Message-----
> > From: Linuxppc-dev
> > <linuxppc-dev-bounces+b29983=freescale.com@lists.ozlabs.org> On
> > Behalf Of Scott Wood
> > Sent: 2018?9?1? 4:29
> > To: Andy Tang <andy.tang@nxp.com>; Vabhav Sharma
> > <vabhav.sharma@nxp.com>; linux-kernel at vger.kernel.org;
> > devicetree at vger.kernel.org; robh+dt at kernel.org;
> > mark.rutland at arm.com; linuxppc-dev at lists.ozlabs.org;
> > linux-arm-kernel at lists.infradead.org; mturquette at baylibre.com;
> > sboyd at kernel.org; rjw at rjwysocki.net; viresh.kumar at linaro.org;
> > linux-clk at vger.kernel.org; linux-pm at vger.kernel.org;
> > linux-kernel-owner at vger.kernel.org; catalin.marinas at arm.com;
> > will.deacon at arm.com; gregkh at linuxfoundation.org; arnd at arndb.de;
> > kstewart at linuxfoundation.org; yamada.masahiro at socionext.com
> > Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>;
> > linux at armlinux.org.uk; Udit Kumar <udit.kumar@nxp.com>; Varun Sethi
> > <V.Sethi@nxp.com>
> > Subject: Re: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for
> > lx2160a
> > 
> > On Fri, 2018-08-31 at 06:12 +0000, Andy Tang wrote:
> > > We don't want to increase NUM_CMUX each time new soc with more
> > 
> > cmuxes added.
> > 
> > You don't want to have to make a trivial change each time you exceed a
> > limit that has yet to be exceeded once since NUM_CMUX was added?
> > This isn't ABI or in any other way hard to change.  It's right in the same
> > file
> > as the chip description you'd be adding.
> > 
> > And even if a chip did come along with 16 cmuxes, you'd then need to
> > increase the array to 17 to hold the -1 if you don't want to leave a
> > situation
> > like the
> > p4080 is in now, where a chip's cmux array could be broken by increasing
> > NUM_CMUX further.
> > 
> 
> [Andy] Adding buffer to a limitation number is always a good habit when
> coding. We often forget to increase this value when
> a new chip with more cmuxes added. 

"often"?  There has never been a new chip added with more cmuxes than p4080's
8, and if one does come along and you forget, the compiler should complain
about exceeding the array length with a static initializer.  This isn't like
an array that is filled with a runtime-determined length.

> Like this patch, we didn't increase this value at first. We spent a lot of
> time finding out that NUM_CMUX needs to be increased too.

Are you talking about some other chip that you haven't sent a patch for yet? 
Or is the cmux array for this chip wrong?  What specifically did you see
happen "at first"?

> It is a personal preference how to set this value. I think it is better to
> increase it to 16, not NUM_CMUX+1 as long as we fix the P4080 issue
> even though it is a trivial change. And I agree the description needs to be
> updated.

I'm not the clock maintainer, so it's not up to me, but I don't see the point
in setting it to an arbitrary number, and I do not agree that increasing
NUM_CMUX is a suitable replacement for NUM_CMUX+1 in cmux_to_group[], as that
array should be one larger than cmux[] in order to allow every chip to have a
-1 terminator.  In any case, any change to NUM_CMUX should be a separate patch
because it's not required for lx2160a support (assuming lx2160a was correctly
described by this patch).

-Scott
