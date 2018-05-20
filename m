From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 20 May 2018 12:57:01 +0200
Subject: [reset-control] How to initialize hardware state with the shared
 reset line?
In-Reply-To: <CAK7LNATZgJ4MxOFLUCNARWv3Zz=gpL-jGReDnBnArquiaXRWoQ@mail.gmail.com>
References: <CAK7LNATZgJ4MxOFLUCNARWv3Zz=gpL-jGReDnBnArquiaXRWoQ@mail.gmail.com>
Message-ID: <CAFBinCADQsXoc6CUKabH6VX3ZBYb5apo-xBbe1w0BiO8wBAsPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 10, 2018 at 11:16 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
[snip]
> I may be missing something, but
> one solution might be reset hogging on the
> reset provider side.  This allows us to describe
> the initial state of reset lines in the reset controller.
>
> The idea for "reset-hog" is similar to:
>  - "gpio-hog" defined in
>    Documentation/devicetree/bindings/gpio/gpio.txt
>  - "assigned-clocks" defined in
>    Documetation/devicetree/bindings/clock/clock-bindings.txt
>
>
>
> For example,
>
>    reset-controller {
>             ....
>
>             line_a {
>                   reset-hog;
>                   resets = <1>;
>                   reset-assert;
>             };
>    }
>
>
> When the reset controller is registered,
> the reset ID '1' is asserted.
>
>
> So, all reset consumers that share the reset line '1'
> will start from the asserted state
> (i.e. defined state machine state).
I wonder if a "reset hog" can be board specific:
- GPIO hogs are definitely board specific (meson-gxbb-odroidc2.dts for
example uses it to take the USB hub out of reset)
- assigned-clock-parents (and the like) can also be board specific (I
made up a use-case since I don't know of any actual examples: board A
uses an external XTAL while board B uses some other internal
clock-source because it doesn't have an external XTAL)

however, can reset lines be board specific? or in other words: do we
need to describe them in device-tree?
we could extend struct reset_controller_dev (= reset controller
driver) if they are not board specific:
- either assert all reset lines by default except if they are listed
in a new field (may break backwards compatibility, requires testing of
all reset controller drivers)
- specify a list of reset lines and their desired state (or to keep it
easy: specify a list of reset lines that should be asserted)
(I must admit that this is basically your idea but the definition is
moved from device-tree to the reset controller driver)

any "chip" specific differences could be expressed by using a
different of_device_id

one the other hand: your "reset hog" solution looks fine to me if
reset lines can be board specific

> From the discussion with Martin Blumenstingl
> (https://lkml.org/lkml/2018/4/28/115),
> the problem for Amlogic is that
> the reset line is "de-asserted" by default.
> If so, the 'reset-hog' would fix the problem,
> and DWC3 driver would be able to use
> shared, level reset, I think.
I think you are right: if we could control the initial state then we
should be able to use level resets


Regards
Martin
