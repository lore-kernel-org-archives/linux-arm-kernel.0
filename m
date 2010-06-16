From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 16 Jun 2010 08:38:38 +0200
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081
	PrimeCells
In-Reply-To: <4C184C1C.4000204@st.com>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
	<4C15C60E.6080404@st.com>
	<AANLkTim9n-p-Pw6FWvzQMBiAuB3h9ILq1Ya6XWk_0l-c@mail.gmail.com>
	<4C170EE2.4010706@st.com>
	<CEE6BB42CAD6E947908279175AF8470A025E5AE1ED@EXDCVYMBSTM006.EQ1STM.local>
	<4C184C1C.4000204@st.com>
Message-ID: <AANLkTinZgUzXy9wH760foYDqbr5gvHO07LkiCco_q8Wj@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Viresh]

> In the same way, how other peripheral related data is passed to DMA driver,
> (like request lines), we can also pass configuration and control information.

Yep.

> In SPEAr6xx, Memory is accessible from Master1
> only but in SPEAr3xx only from Master 2, similar is the pattern with few
> peripherals also and so i need control over DMA channel configuration.

Oh I had no clue that you could set up your masters like that!
Anyway, I'll attempt to hack in some platform config for how
the AHB masters are assigned, but you'll likely have to patch it
to work with SPEAr in the end.

>> Currently only done dynamically with DMA as the master for
>> Mem2mem, mem2per and per2mem. Mastering from the peripherals
>> is not supported. Do you have advanced features like that?
>
> We have JPEG controller, which acts as a flow controller for JPEG to
> mem transfer. (Synopsys JPEG Controller).

OK that's special..

>> Anyway it can be passed in from platform data easily.
>
> But platform data will be passed one time only and we will not be able to
> do it while transferring data at run time.

Usually there is a very fixed use for each virtual DMA channel (which
have a platform config each), i.e. usually there is only one or two
flow controls per virtual channel. So in this case I guess that
Synopsys JPEG has a virtual channel that always is JPEG->mem with
JPEG as master, so it can actually be in fix platform data?

Anyway, we can probably extended either the way we did for PrimeCells
or in some generic way by adding config commands to the DMAengine,
so I see no road blocker.

Yours,
Linus Walleij
