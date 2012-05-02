From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 02 May 2012 09:27:35 -0600
Subject: [PATCH] gpiolib: Add of_get_gpio_chip_by_phandle() helper
In-Reply-To: <cdf5352edf6b32e2505e1c7ba9997613150094c1.1335949228.git.viresh.kumar@st.com>
References: <cdf5352edf6b32e2505e1c7ba9997613150094c1.1335949228.git.viresh.kumar@st.com>
Message-ID: <4FA15267.4090306@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/2012 03:04 AM, Viresh Kumar wrote:
> There is a requirement in pinctrl subsystem, to bind pinctrl driver with
> gpio_chip.

Could you please explain more? I don't believe that's true.

It's certainly possible that the same driver can be both a pinctrl
driver and a GPIO driver if this is how the HW works. However, in this
case, the device tree would contain a single node to represent that HW
module, and the driver for that node would then register itself as both
a GPIO chip and a pinctrl driver. In other words, device tree content
shouldn't be influenced by this (except of course that the single node
would contain both GPIO provider and pinctrl provider properties)

When GPIO and pinmux HW are separate but interact, the GPIO/pinctrl
driver interaction is for the GPIO driver to call into pinctrl if
required. However, this is through the generic functions such as
pinctrl_request_gpio() which take global GPIO numbers, and hence have no
need for a specific GPIO driver handle.
