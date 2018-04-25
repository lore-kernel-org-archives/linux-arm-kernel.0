From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 25 Apr 2018 18:55:10 +0800
Subject: [PATCH v3 2/3] regulator: add support for SY8106A regulator
In-Reply-To: <20180425105309.GC24769@sirena.org.uk>
References: <20180423144657.63264-1-icenowy@aosc.io>
 <20180423144657.63264-3-icenowy@aosc.io>
 <20180424170733.GD22073@sirena.org.uk>
 <C0C1F042-221A-420F-A8C1-5FADCFC687F1@aosc.io>
 <20180425105309.GC24769@sirena.org.uk>
Message-ID: <15C93A9B-6EEB-49EB-A942-35F761E86569@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?4?25? GMT+08:00 ??6:53:09, Mark Brown <broonie@kernel.org> ??:
>On Wed, Apr 25, 2018 at 07:41:35AM +0800, Icenowy Zheng wrote:
>> ? 2018?4?25? GMT+08:00 ??1:07:33, Mark Brown <broonie@kernel.org> ??:
>> >On Mon, Apr 23, 2018 at 10:46:56PM +0800, Icenowy Zheng wrote:
>
>> >> --- /dev/null
>> >> +++ b/drivers/regulator/sy8106a-regulator.c
>> >> @@ -0,0 +1,176 @@
>> >> +// SPDX-License-Identifier: GPL-2.0+
>> >> +/*
>> >> + * sy8106a-regulator.c - Regulator device driver for SY8106A
>
>> >Just make the entire thing a C++ comment so it looks consistent and
>> >joined up.
>
>> SPDX identifier is special -- it should be in a seperated
>> comment block.
>
>No, it just needs to be a C++ comment on the first line to ease machine
>parsing.  The rest of the file doesn't matter for that.

Okay. Thus I will use a seperate /* */ block for it in the
next revision, to follow the rule.

>
>> >> +	if (reg & SY8106A_GO_BIT)
>> >> +		return reg & rdev->desc->vsel_mask;
>> >> +	else
>> >> +		return (chip->fixed_voltage - rdev->desc->min_uV) /
>> >> +		       rdev->desc->uV_step;
>
>> >You could use the standard get_voltage_sel() if you provide a
>mapping
>> >operation that set everything with _GO_BIT set to return the fixed
>> >voltage.  Though looking at this it seems that the fixed voltage
>will
>> >always be one that could be set via the register anyway so I'm
>> >wondering
>> >if the easiest thing here isn't to just have the driver turn off
>> >_GO_BIT
>
>> Do you mean "turn on" here?
>
>Yes.

Okay. I will do it in this way and drop custom get/set_voltage_sel.
