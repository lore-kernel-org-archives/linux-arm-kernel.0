From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 27 Jan 2014 15:45:32 +0100
Subject: [PATCH 05/11] pinctrl: mvebu: fix misdesigned resource allocation
In-Reply-To: <1390674856-4993-6-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1390674856-4993-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1390674856-4993-6-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140127154532.4bc3eeef@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Sat, 25 Jan 2014 19:34:10 +0100, Sebastian Hesselbarth wrote:
> Allocating the pinctrl resource in common pinctrl-mvebu was a misdesign,
> as it does not allow SoC specific parts to access the allocated resource.
> This moves resource allocation from mvebu_pinctrl_probe to SoC specific
> _probe functions and passes the base address to common pinctrl driver
> instead.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

I definitely agree with that: I had the same problem several months ago
when I started doing the pinctrl driver for Orion5x, which has a
non-linear MPP register set.

However, I'd like this to go a little bit further if possible. See
below.


> -	return mvebu_pinctrl_probe(pdev);
> +	return mvebu_pinctrl_probe(pdev, base);

I think there is no need to pass "base" to mvebu_pinctrl_probe(). The
only reason we have this is because the base gets stored in the
mvebu_pinctrl structure so that the mvebu_common_mpp_get() and
mvebu_common_mpp_set() functions that are the default behavior
for mvebu_pinconf_group_get() and mvebu_pinconf_group_set() work
properly.

Shouldn't we turn these functions mvebu_common_mpp_get() and
mvebu_common_mpp_set() into helper functions, accessible from the
per-SoC pinctrl drivers, so that they can easily implement their
->mpp_get() and ->mpp_set() callbacks?

This way, the "base" thing is completely owned by the per-SoC driver,
which would be more logical I believe.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
