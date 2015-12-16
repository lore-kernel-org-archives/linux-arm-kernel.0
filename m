From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 16 Dec 2015 16:55:00 +0100
Subject: [PATCH v2] pwm: ftm: fix clock enable/disable when using PM
In-Reply-To: <1448318707-18011-1-git-send-email-stefan@agner.ch>
References: <1448318707-18011-1-git-send-email-stefan@agner.ch>
Message-ID: <20151216155500.GH28947@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 02:45:07PM -0800, Stefan Agner wrote:
> A FTM PWM instance enables/disables three clocks: The bus clock, the
> counter clock and the PWM clock. The bus clock gets enabled on
> pwm_request, whereas the counter and PWM clocks will be enabled upon
> pwm_enable.
> 
> The driver has three closesly related issues when enabling/disabling
> clocks during suspend/resume:
> - The three clocks are not treated differently in regards to the
>   individual PWM state enabled/requested. This can lead to clocks
>   getting disabled which have not been enabled in the first place
>   (a PWM channel which only has been requested going through
>   suspend/resume).
> 
> - When entering suspend, the current behavior relies on the
>   FTM_OUTMASK register: If a PWM output is unmasked, the driver
>   assumes the clocks are enabled. However, some PWM instances
>   have only 2 channels connected (e.g. Vybrid's FTM1). In that case,
>   the FTM_OUTMASK reads 0x3 if all channels are disabled, even if
>   the code wrote 0xff to it before. For those PWM instances, the
>   current approach to detect enabled PWM signals does not work.
> 
> - A third issue applies to the bus clock only, which can get enabled
>   multiple times (once for each PWM channel of a PWM chip). This is
>   fine, however when entering suspend mode, the clock only gets
>   disabled once.
> 
> This change introduces a different approach by relying on the enable
> and prepared counters of the clock framework and using the frameworks
> PWM signal states to address all three issues.
> 
> Clocks get disabled during suspend and back enabled on resume
> regarding to the PWM channels individual state (requested/enabled).
> 
> Since we do not count the clock enables in the driver, this change no
> longer clears the Status and Control registers Clock Source Selection
> (FTM_SC[CLKS]). However, since we disable the selected clock anyway,
> and we explicitly select the clock source on reenabling a PWM channel
> this approach should not make a difference in practice.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Hi Lee,
> 
> I just found your new email address. Thierry and I already had some
> discussion about the patch here:
> http://thread.gmane.org/gmane.linux.pwm/2878
> 
> Could you have a look at that patch?
> 
> Changes since v1:
> - Use the pwm_is_enabled helper
> 
>  drivers/pwm/pwm-fsl-ftm.c | 58 ++++++++++++++++++++---------------------------
>  1 file changed, 25 insertions(+), 33 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151216/5b8f0a5a/attachment.sig>
