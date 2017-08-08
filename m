From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 8 Aug 2017 17:37:12 +0200
Subject: [PATCH v7 1/4] clk: Add support for runtime PM
In-Reply-To: <1501839294-478-2-git-send-email-m.szyprowski@samsung.com>
References: <1501839294-478-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170804093515eucas1p2226e597c155e5c4ca4ffea95c9e00392@eucas1p2.samsung.com>
 <1501839294-478-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170808153712.GA2646@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 04, 2017 at 11:34:51AM +0200, Marek Szyprowski wrote:
> Registers for some clocks might be located in the SOC area, which are under the
> power domain. To enable access to those registers respective domain has to be
> turned on. Additionally, registers for such clocks will usually loose its
> contents when power domain is turned off, so additional saving and restoring of
> them might be needed in the clock controller driver.
> 
> This patch adds basic infrastructure in the clocks core to allow implementing
> driver for such clocks under power domains. Clock provider can supply a
> struct device pointer, which is the used by clock core for tracking and managing
> clock's controller runtime pm state. Each clk_prepare() operation
> will first call pm_runtime_get_sync() on the supplied device, while
> clk_unprepare() will do pm_runtime_put_sync() at the end.
> 
> Additional calls to pm_runtime_get/put functions are required to ensure that any
> register access (like calculating/changing clock rates and unpreparing/disabling
> unused clocks on boot) will be done with clock controller in runtime resumend
> state.
> 
> When one wants to register clock controller, which make use of this feature, he
> has to:
> 1. Provide a struct device to the core when registering the provider.
> 2. Ensure to enable runtime PM for that device before registering clocks.
> 3. Make sure that the runtime PM status of the controller device reflects
>    the HW state.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/clk/clk.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 114 insertions(+), 15 deletions(-)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
