From: wpdster@gmail.com (Patrick Doyle)
Date: Tue, 9 Aug 2016 10:55:36 -0400
Subject: How does the kernel assign ttySn to UARTs?
In-Reply-To: <CAF_dkJD5MEfNzrRqM3H_LkOmXC3XYjUYLe2=ZtzCjAS1A2TDmg@mail.gmail.com>
References: <CAF_dkJD5MEfNzrRqM3H_LkOmXC3XYjUYLe2=ZtzCjAS1A2TDmg@mail.gmail.com>
Message-ID: <CAF_dkJDk0F+rDBs3=LxM_YWYE6AzwRMkSie-ZQabWYRws-fOsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 8, 2016 at 3:56 PM, Patrick Doyle <wpdster@gmail.com> wrote:
> Would any experts out there care to point me in the direction of some clues?


Thank you Frank for your response... I found some clues on my own.
The biggest clue was that I spelled "aliases" incorrectly (having
spelled it "alias" instead of "aliases").

I found my second clue when I found that the Atmel supplied .dtsi file
also defined some aliases for the serial ports.  (And they managed to
spell "aliases" correctly).

And I found my final clue right where I should have started looking...
in the source.  I looked in the Atmel serial driver and saw how it
assigned serial port numbers first by any aliases if they were
defined, and then sequentially.  So, I now have:

    aliases {
        serial0 = &uart2; /* UART2 <=> /dev/ttyS0 (connected to
mobility board) */
        serial1 = &uart5; /* FLEXCOM4 <=> /dev/ttyS1 (console) */
        serial2 = &uart3; /* UART2 <=> /dev/ttyS2 */
    };


which works the want it to, and, more importantly, I understand why it
works that way :-)

Thanks for playing.

--wpd
