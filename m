From: dianders@chromium.org (Doug Anderson)
Date: Wed, 3 Dec 2014 09:53:40 -0800
Subject: [PATCH v2] i2c: rk3x: fix bug that cause measured high_ns doesn't
 meet I2C spec
In-Reply-To: <20141203111518.GB1039@katana>
References: <1415261514-4051-1-git-send-email-addy.ke@rock-chips.com>
 <1417574237-4328-1-git-send-email-addy.ke@rock-chips.com>
 <20141203111518.GB1039@katana>
Message-ID: <CAD=FV=X5inPWZakhgDX0dX=1CWXygEi3_AH9FVFWXYT3LZA5bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram,

On Wed, Dec 3, 2014 at 3:15 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> + - rise-ns : Number of nanoseconds the signal takes to rise (t(r) in i2c spec).
>> +          If not specified this is assumed to be the max the spec allows
>> +          (1000 ns for standard mode, 300 ns for fast mode) which might
>> +          cause slightly slower communication.
>> + - fall-ns : Number of nanoseconds the signal takes to fall (t(f) in the i2c0
>> +          spec).  If not specified this is assumed to be the max the spec
>> +          allows (300 ns) which might cause slightly slower communication.
>
> We already have those bindings from the designware driver:
>
>  - i2c-sda-hold-time-ns : should contain the SDA hold time in nanoseconds.
>  - i2c-scl-falling-time : should contain the SCL falling time in nanoseconds.
>  - i2c-sda-falling-time : should contain the SDA falling time in nanoseconds.
>
> Can you reuse them? Or do you really need a specific rise-time property?
> If so, please matche the style of the bindings above.

Ah, doh!  I should have thought to look for existing bindings.  Sorry
about that.  :(

If you don't read all the below, my belief is that we should simply
rename the strings in Addy's patch.  We should change "rise-ns" to
"i2c-scl-rising-time" and "fall-ns" to "i2c-scl-falling-time".
Wolfram: can you confirm this is OK?  I'm voting to leave the "-ns"
off the end of both to avoid asymmetry.

---

Details:

Hrm, we seem to need different parameters than designware i2c.  The
designware bus is specifying "i2c-sda-hold-time-ns".  On Rockchip i2c
we specify just the number of cycles that the clk line should be high
and the number of cycles that it should be low.  The adapter does the
rest of the work.  As I understand it, the data hold time on Rockchip
i2c is equal to half the low time, for instance.  That was indicated
by Addy who talked to the IC engineer.

Because of the above, I _think_ that means that specifying
"i2c-sda-hold-time-ns" is not appropriate for us, or at least not easy
to convert in a sane way.

We could add a "i2c-scl-hold-time-ns", but if I understand correctly I
think that the "rise-time" describes the hardware in a cleaner way.
If you specify the hold time then (I think) that it requires the user
to tweak it whenever he/she adjusts the bus speed.  In other words if
you have a bus and you decide to move it from running at 400kHz to
running at 300kHz (signal integrity issues?) or 100kHz, you need to
manually modify the hold time.  ...on the other hand the rise time is
a property of the hardware I think (size of resistor, etc).

For the falling times I guess we should use the "i2c-scl-falling-time"
and not list the "i2c-sda-falling-time" for now?  As per above the
controller takes in the high/low period of the clocks and figures out
the rest itself.  Possibly we will need to account for
i2c-sda-falling-time eventually, but maybe that can come later?


-Doug
