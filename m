From: dianders@chromium.org (Doug Anderson)
Date: Fri, 13 Mar 2015 13:27:58 -0700
Subject: [PATCH] mmc: dw_mmc: Consider HLE errors to be data and command
 errors
In-Reply-To: <5502CA4E.9060401@samsung.com>
References: <1426002490-2014-1-git-send-email-dianders@chromium.org>
 <5502CA4E.9060401@samsung.com>
Message-ID: <CAD=FV=VX3ix-j4y95W1q8b-aVuVEN+4xsd8WLx2xcE7KPNJwRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 13, 2015 at 4:30 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi, Doug.
>
> On 03/11/2015 12:48 AM, Doug Anderson wrote:
>> The dw_mmc driver enables HLE errors as part of DW_MCI_ERROR_FLAGS but
>> nothing in the interrupt handler actually handles them and ACKs them.
>> That means that if we ever get an HLE error we'll just keep getting
>> interrupts and we'll wedge things.
>>
>> We really don't expect HLE errors but if we ever get them we shouldn't
>> silently ignore them.
>>
>> Note that I have seen HLE errors while constantly ejecting and
>> inserting cards (ejecting while inserting, etc).
>
> Right, It is occurred when card inserting/ejecting.(This case is the case of removable card.)
> Did you test with eMMC? We needs to consider how control HLE error.

I'm running it on systems with eMMC, SD Cards, and SDIO WiFi.  HLE
doesn't show up in normal circumstances, only in ejecting the SD card
at the wrong time.  ...since you can't eject eMMC, I didn't see
problems there.

> But I think this patch can't solve all of HLE problem.

Agreed.  HLE means that the controller is pretty wedged and (as I
understand it) means that there's something else we're doing wrong
elsewhere in the dw_mmc driver (like writing more data to an already
busy controller).  We should probably track down and find those cases,
too.

I agree also that this code probably won't fix the controller in all
cases of HLE errors.  ...but I'm not 100% certain of the best way to
really do that, do you know?

...but in any case the absolute worst thing to do is what the driver
is already doing: unmask the HLE interrupt but never handle it
anywhere...  My patch is at least better than that...

If you have another suggested way to make HLE error handling better
(or avoid them to begin with) I'm happy to test!  :)


-Doug
