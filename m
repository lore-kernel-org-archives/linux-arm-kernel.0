From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 1 Mar 2017 08:50:23 -0600
Subject: [PATCH] Documentation: dt: Add binding for
 /chosen/secure-stdout-path
In-Reply-To: <06154a2280a8423af80405825d7201c7aa927696.1488374335.git.jerome.forissier@linaro.org>
References: <06154a2280a8423af80405825d7201c7aa927696.1488374335.git.jerome.forissier@linaro.org>
Message-ID: <CAL_JsqKrUCCvGD_LKvOx+s8zh30GC_v=HAyqozgRm=7mcfSZzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 1, 2017 at 7:29 AM, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
> Some platforms may use a single device tree to describe two address
> spaces, as described in d9f43babb998 ("Documentation: dt: Add bindings
> for Secure-only devices"). We extend the use of the secure- prefix to
> the stdout-path property, so that the Secure firmware may use a
> different console device than the one used by the kernel.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/secure.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/secure.txt b/Documentation/devicetree/bindings/arm/secure.txt
> index e31303f..558c9a1 100644
> --- a/Documentation/devicetree/bindings/arm/secure.txt
> +++ b/Documentation/devicetree/bindings/arm/secure.txt
> @@ -51,3 +51,8 @@ Valid Secure world properties:
>     status = "disabled"; secure-status = "okay";     /* S-only */
>     status = "disabled";                             /* disabled in both */
>     status = "disabled"; secure-status = "disabled"; /* disabled in both */
> +
> +- secure-stdout-path (/chosen node): specifies the device to be used
> +for console output by Secure firmware. The syntax is the same as for
> +"stdout-path". If "secure-stdout-path" is not specified it defaults to
> +the same value as "stdout-path".

I'm not all that enthusiastic about this. This alone is okay, but
continued additions of secure-* properties doesn't seem very scalable.
Is this it or do you have other needs? What happens when we have 3
modes/address spaces?

Maybe we should allow stdout-path to have multiple strings and secure
fw grabs the first one and updates the DT removing it (perhaps only if
the device is secure only). Might be nice to have multiple ones
supported anyway (like we can do on the kernel command line:
"console=ttyS0 console=ttyS1").

Rob
