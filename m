From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 05 Dec 2014 12:22:02 +0100
Subject: [PATCH v4 1/3] clk: samsung: Fix clock disable failure because
 domain being gated
In-Reply-To: <1417777254-26579-2-git-send-email-k.kozlowski@samsung.com>
References: <1417777254-26579-1-git-send-email-k.kozlowski@samsung.com>
 <1417777254-26579-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <5481955A.9000703@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier,

On 05/12/14 12:00, Krzysztof Kozlowski wrote:
> Audio subsystem clocks are located in separate block. If clock for this
> block (from main clock domain) 'mau_epll' is gated then any read or
> write to audss registers will block.
> 
> This was observed on Exynos 5420 platforms (Arndale Octa and Peach
> Pi/Pit) after introducing runtime PM to pl330 DMA driver. After that
> commit the 'mau_epll' was gated, because the "amba" clock was disabled
> and there were no more users of mau_epll. The system hang on disabling
> unused clocks from audss block.
> 
> Unfortunately the 'mau_epll' clock is not parent of some of audss clocks.
> 
> Whenever system wants to operate on audss clocks it has to enable epll
> clock. The solution reuses common clk-gate/divider/mux code and duplicates
> clk_register_*() functions.
> 
> Additionally this patch fixes memory leak of clock gate/divider/mux
> structures. The leak exists in generic clk_register_*() functions. Patch
> replaces them with custom code with managed allocation.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Reported-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Reported-by: Kevin Hilman <khilman@kernel.org>
> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Can you confirm sound works with this patch on exynos5420 ? Or does
your Tested-by refer only to successful booting ?

--
Thanks,
Sylwester
