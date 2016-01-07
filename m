From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 7 Jan 2016 17:19:59 +0000
Subject: [Qemu-devel] arm64 qemu tests failing in linux-next since 'arm64:
 kernel: enforce pmuserenr_el0 initialization and restore'
In-Reply-To: <568E9BF6.6020809@roeck-us.net>
References: <567B41E3.5060800@roeck-us.net>
 <CAFEAcA_c9DicGF+is6ST3NJv+c5Bi4dHYo2t8Q2n9AS9G4q0+Q@mail.gmail.com>
 <20160107155310.GA4064@red-moon>
 <CAFEAcA_vP93=PE6LNNHodCsdk0gL0kBQPX=xzLJU5RzkvNs2vw@mail.gmail.com>
 <20160107163722.GB4064@red-moon> <568E9BF6.6020809@roeck-us.net>
Message-ID: <CAFEAcA8rhU93urnqVRFy78Q0JNRD=1mUPe2fjXbUs4WRYWoHoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 January 2016 at 17:10, Guenter Roeck <linux@roeck-us.net> wrote:
> Strictly speaking you may be right (regression is a bit strong, though),
> but for my part I tend to be pragmatic.
>
> A warning message such as "Access to unimplemented register X" may be
> useful

You can get these from QEMU if you pass it "-d unimp", which logs
various kinds of things-not-yet-implemented, with a couple of caveats:
 * the warning is when we translate the code, not when we execute it
 * it won't warn for registers which we implement but not completely
   (eg only partial functionality or dummy reads-as-written)

In this case it printed
"write access to unsupported AArch64 system register op0:3 op1:3 crn:9
crm:14 op2:0"

The 'guest_errors' suboption to -d warns about things which appear
to be errors in the guest OS, for instance some kinds of UNPREDICTABLE,
and may also be of interest.

Neither guest_errors nor unimp are comprehensive (there are many
more situations where we don't warn than where we do) but they can
be helpful sometimes.

thanks
-- PMM
