From: kernel@martin.sperl.org (Martin Sperl)
Date: Mon, 8 Feb 2016 14:30:39 +0100
Subject: [RFC 2/9] clk: bcm2835: add support for parent selection in DT
In-Reply-To: <20160121082642.GB13237@pengutronix.de>
References: <1453215100-2382-1-git-send-email-kernel@martin.sperl.org>
 <1453215100-2382-3-git-send-email-kernel@martin.sperl.org>
 <20160121082642.GB13237@pengutronix.de>
Message-ID: <56B8987F.1080701@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21.01.2016 09:26, Sascha Hauer wrote:
> Martin,
>
> On Tue, Jan 19, 2016 at 02:51:33PM +0000, kernel at martin.sperl.org wrote:
>> From: Martin Sperl <kernel@martin.sperl.org>
>>
>> Allow for a per clock custom selection of clocks in the device tree.
>>
>> Basic setup in dt looks like this:
>>    clock at BCM2835_CLOCK_PCM {
>>      reg = <BCM2835_CLOCK_PCM>;
>>      parent-clock-names = "xosc", "plld_per", "plla_per", "pll_aux_per";
>>    };
>
> Isn't this the same as the already existing assigned-clock-parents property?
> If yes, that should be used.
It is not 100% identical, as the parent-clock-names do provide ordering
of clocks to be selected, which - under some circumstances may be
beneficial - e.g: when having a parent clock with 500MHz and 1000MHz,
then the higher clock could get given preference by switching ordering...

Also when using:
assigned-clock-parents = <&clk_osc 0>, <&clocks BCM2835_PLLD_PER>;

I get strange indexes passed when calling set_parent - so this would
need to get rewritten to support assigned-clock-parents correctly -
calculating the index on the fly...
