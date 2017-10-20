From: harinikatakamlinux@gmail.com (Harini Katakam)
Date: Fri, 20 Oct 2017 10:34:44 +0530
Subject: [PATCH] Fix Bug for cadence i2c interrupt overrunning buffer
In-Reply-To: <CA+Y=x3kpy0LE-mqjKWS8QWy7qzS2pNdDMHpDqZXRGvdt-UbYcA@mail.gmail.com>
References: <20170916030252.10680-1-amworsley@gmail.com>
 <20171005120125.nnhomwg2e2twbaqm@ninjato>
 <CA+Y=x3=Ab-tZt-32Ve1qTB=REuQAZnGbX72ZeNpyX3EX7cR0pg@mail.gmail.com>
 <20171013184646.cy5gmpwrxbacje3m@ninjato>
 <CAFcVECJTUu7Kwd-2hx=4=iGwKFnpTAebR3ffjJHQLHKDZ3T4aw@mail.gmail.com>
 <CA+Y=x3nnQ0hQkBaGQ4+MDZsVgpdFCYqaMae9UrJ2vOOuAD9FdQ@mail.gmail.com>
 <CAFcVECK85xW_8oxVQGsHBGyZ4_5bcghpbonqDH-8tLp+Mwq=xQ@mail.gmail.com>
 <CA+Y=x3kpy0LE-mqjKWS8QWy7qzS2pNdDMHpDqZXRGvdt-UbYcA@mail.gmail.com>
Message-ID: <CAFcVECLWwo+OxSGAGYJfMSesjNT51X+Cwk+E_-RQk7gsEXy2YQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Wed, Oct 18, 2017 at 3:11 PM, Andrew Worsley <amworsley@gmail.com> wrote:
<snip>
> Perhaps this information gives some one a path to investigate further?
> I can't really see how this transfer size register can get confused -
> especially always with 240 or 242 = 255-13
> Perhaps the transfer register rolls over from zero or something?
> Or Perhaps I am just looking for magic numbers?

Thanks for the debug Andrew..
We do have one known issue for Zynq:
https://www.xilinx.com/support/answers/61664.html
The patch for >252 byte transfers was a workaround to this.
In short, the I2C master generates invalid clocks and
starts reading extra bytes (0xFFs) when the transfer size register
reaches zero and the hold bit is set (as is the case with >252 transfers).
The transfer size register does roll over to 255 in this case.
But in case of 242 bytes or all the other values (13, 142) written
to transfer size register, I don't see this errata coming into picture.

<snip>

> I attach a patch of the changes to the i2c driver showing my debug in
> this driver.
> As I said I am happy to send more verbose bug output - I have about 36
> odd runs with 9 occurences of the bug.
> Once it happen twice in the one run
>
> I include the crashing line from the runs where the bug occured (I
> added more diagnostics as the runs progressed):

I'll check with out HW team as well and check your flow to
see if we can reproduce it; will also check if the existing errata
has larger scope.
I'll let you know if we require further assistance with debug
next week.

Regards,
Harini
