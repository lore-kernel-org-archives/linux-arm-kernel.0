From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 04 Nov 2014 10:32:26 +0100
Subject: [PATCH 09/17] clk: mvebu: add suspend/resume for gatable clocks
In-Reply-To: <1414151970-6626-10-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-10-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <54589D2A.5060807@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 24/10/2014 13:59, Thomas Petazzoni wrote:
> This commit adds suspend/resume support for the gatable clock driver
> used on Marvell EBU platforms. When getting out of suspend, the
> Marvell EBU platforms go through the bootloader, which re-enables all
> gatable clocks. However, upon resume, the clock framework will not
> disable again all gatable clocks that are not used.
> 
> Therefore, if the clock driver does not save/restore the state of the
> gatable clocks, all gatable clocks that are not claimed by any device
> driver will remain enabled after a resume. This is why this driver
> saves and restores the state of those clocks.
> 
> Since clocks aren't real devices, we don't have the normal ->suspend()
> and ->resume() of the device model, and have to use the ->suspend()
> and ->resume() hooks of the syscore_ops mechanism. This mechanism has
> the unfortunate idea of not providing a way of passing private data,
> which requires us to change the driver to make the assumption that
> there is only once instance of the gatable clock control structure.

It should be possible to store more than one instance in an array, and
to go trough this array during suspend and resume. However until now we
never had needed more than one instance, so I agree to keep the code simple
with this assumption.

> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/clk/mvebu/common.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
