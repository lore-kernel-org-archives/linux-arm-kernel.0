From: robh@kernel.org (Rob Herring)
Date: Fri, 20 May 2016 16:49:06 -0500
Subject: [RFC PATCH 1/2] Input: rotary-encoder- Add support for absolute
 encoder
In-Reply-To: <1463648641-6931-2-git-send-email-vigneshr@ti.com>
References: <1463648641-6931-1-git-send-email-vigneshr@ti.com>
 <1463648641-6931-2-git-send-email-vigneshr@ti.com>
Message-ID: <20160520214906.GA20973@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2016 at 02:34:00PM +0530, Vignesh R wrote:
> There are rotary-encoders where GPIO lines reflect the actual position
> of the rotary encoder dial. For example, if dial points to 9, then four
> GPIO lines connected to the rotary encoder will read HLLH(1001b = 9).
> Add support for such rotary-encoder.
> The driver relies on rotary-encoder,absolute-encoder DT property to
> detect such encoders.
> Since, GPIO IRQs are not necessary to work with
> such encoders, optional polling mode support is added using
> input_poll_dev skeleton. This is can be used by enabling
> CONFIG_INPUT_GPIO_ROTARY_ENCODER_POLL_MODE_SUPPORT.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  .../devicetree/bindings/input/rotary-encoder.txt   |   4 +
>  Documentation/input/rotary-encoder.txt             |   9 ++
>  drivers/input/misc/Kconfig                         |  11 ++
>  drivers/input/misc/rotary_encoder.c                | 165 ++++++++++++++++-----
>  4 files changed, 155 insertions(+), 34 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> index 6c9f0c8a846c..9c928dbd1500 100644
> --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
> +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> @@ -12,6 +12,10 @@ Optional properties:
>  - rotary-encoder,relative-axis: register a relative axis rather than an
>    absolute one. Relative axis will only generate +1/-1 events on the input
>    device, hence no steps need to be passed.
> +- rotary-encoder,absolute-encoder: support encoders where GPIO lines
> +  reflect the actual position of the rotary encoder dial. For example,
> +  if dial points to 9, then four GPIO lines read HLLH(1001b = 9).
> +  In this case, rotary-encoder,steps-per-period needed not be defined.

I think this should be done as a new compatible string rather than a 
property. It seems like fundamentally different h/w.

Rob
