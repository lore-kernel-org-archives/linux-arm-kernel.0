From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 04 Nov 2013 17:04:14 -0700
Subject: [PATCH 3/4] ARM: pinctrl: Add Broadcom Capri pinctrl driver
In-Reply-To: <201311050026.56321.heiko@sntech.de>
References: <1380846199-12829-1-git-send-email-syin@broadcom.com>
 <051069C10411E24D9749790C498526FA1BE0B7D7@SJEXCHMB12.corp.ad.broadcom.com>
 <CACRpkdYSLxp2M4HghcUdjEYGh-UQ+DaiCGp6yee+Qds6DR9poA@mail.gmail.com>
 <201311050026.56321.heiko@sntech.de>
Message-ID: <527835FE.2030102@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2013 04:26 PM, Heiko St?bner wrote:

> I remember we had a discussion about how things like bias-disable explicitly 
> shouldn't have a value, when they are represented in the list-format:
> 
> 		pcfg_pull_none: pcfg_pull_none {
> 			bias-disable;
> 		};
> 
> so a bias-disable = <1> was explicitly "forbidden" [for a lack of a better 
> word]. And it was similar for other options, the parameter not meant to be 
> indicating if they are active but really only setting the "strength" or so.

Pure Boolean values should be represented as a valueless property. If
the property is present, the value is true, otherwise false.

However, pinctrl bindings often don't represent Boolean values, but
rather tri-states, with the following values:

* Don't touch this configuration option at all (missing)
* Enable the option (<1>)
* Disable the option (<0>)

The reason for using tri-states being that you might want to write:

xxx1 {
    pins = <PINA>, <PINB>, <PINC>;
    function = <...>;
    // this node doesn't affect pullup
}
xxx2 {
    pins = <PINA>, <PINB>;
    // this node doesn't affect function
    pull-up = <1>; // change, and enable
}
xxx3 {
    pins = <PINAC>;
    // this node doesn't affect function
    pull-up = <0>; // change, and disable
}
