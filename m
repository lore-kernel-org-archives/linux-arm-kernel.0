From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 25 Jul 2017 10:55:17 -0700
Subject: Problem with PHY state machine when using interrupts
In-Reply-To: <e2f4ef4a-c667-3bdf-e4ea-2767dc6a4922@free.fr>
References: <65b9f1f5-724c-cd03-1c39-59405e773efa@free.fr>
 <849513d9-c981-ec20-5a10-08c663d0aa37@free.fr>
 <02e9e171-ec22-e491-5bc8-ef4b3ad7fec2@gmail.com>
 <e6a7a5df-b735-6f9c-6a2b-cded86ec6525@free.fr>
 <b0410a73-ff2d-ca06-93fa-17af2040c41c@gmail.com>
 <0f56083f-d43e-a141-1470-b76546af6d58@gmail.com>
 <c81e12bc-0f89-5eab-547e-f0c1ec389ad8@free.fr>
 <62085f48-df18-f987-f521-dcdfbd7f574b@gmail.com>
 <eb09bda5-c972-0c2c-2693-982c02c8c87c@gmail.com>
 <1c00935b-3a3c-4268-db99-a0487ddece76@free.fr>
 <e2f4ef4a-c667-3bdf-e4ea-2767dc6a4922@free.fr>
Message-ID: <E5207219-42E8-42FB-9E92-D3F424E2AD8C@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On July 25, 2017 4:41:32 AM PDT, Mason <slash.tmp@free.fr> wrote:
>On 25/07/2017 12:51, Mason wrote:
>
>> Moving the call to phy_stop() down after all the MAC tear down
>> avoids the hang.
>> 
>> As far as I understand, when we are shutting everything down,
>> we don't need the phy_state_machine to run asynchronously.
>> We can run it synchronously one last time after the delayed
>> stuff has been disabled.
>
>Below is my current WIP diff. (It conflates the two issues
>I've been discussing. Splitting the diff required.)
>
>Tested in interrupt mode:
>
># ip link set eth0 up
>[   11.107547] Atheros 8035 ethernet 26000.nb8800-mii:04: PHY state
>change UP -> AN
>[   14.530329] nb8800 26000.ethernet eth0: Link is Up - 1Gbps/Full -
>flow control rx/tx
>[   14.538136] Atheros 8035 ethernet 26000.nb8800-mii:04: PHY state
>change AN -> RUNNING
># ip link set eth0 down
>[   23.801018] nb8800 26000.ethernet eth0: Link is Down
># ip link set eth0 up
>[   28.740870] Atheros 8035 ethernet UP26000.nb8800-mii:04: PHY state
>change UP -> AN
>[   31.431528] nb8800 26000.ethernet eth0: Link is Up - 1Gbps/Full -
>flow control rx/tx
>[   31.439350] Atheros 8035 ethernet 26000.nb8800-mii:04: PHY state
>change AN -> RUNNING
>
>Works as expected.

It does indeed, although this probably also contains your change that only logs the PHY state machine transitions, which makes me wonder why the UP -> HALTED state is not logged?

>
>Tested in polling mode:
>
># ip link set eth0 up
>[   23.001199] Atheros 8035 ethernet 26000.nb8800-mii:04: PHY state
>change UP -> AN
>[   24.024315] Atheros 8035 ethernet 26000.nb8800-mii:04: PHY state
>change AN -> NOLINK
>[   27.064355] nb8800 26000.ethernet eth0: Link is Up - 1Gbps/Full -
>flow control rx/tx
>[   27.072156] Atheros 8035 ethernet 26000.nb8800-mii:04: PHY state
>change NOLINK -> RUNNING
># ip link set eth0 down
>[   42.134617] nb8800 26000.ethernet eth0: Link is Down
># ip link set eth0 up
>[   48.381185] Atheros 8035 ethernet 26000.nb8800-mii:04: PHY state
>change UP -> AN
>[   49.410976] Atheros 8035 ethernet 26000.nb8800-mii:04: PHY state
>change AN -> NOLINK
>[   51.437686] nb8800 26000.ethernet eth0: Link is Up - 1Gbps/Full -
>flow control rx/tx
>[   51.445486] Atheros 8035 ethernet 26000.nb8800-mii:04: PHY state
>change NOLINK -> RUNNING
>
>Works as expected.
>
>Also tested on my old board, no regression seen.
>
>Can you confirm that the changes to drivers/net/phy/phy.c
>look reasonable?

The flush is correct, but I am not sure about the explicit state change, in two ways:

- in polling mode, we should already be reaching that state with the flush call AFAICT
- in interrupt driven mode (phy_interrupt_is_valid or PHY_IGNORE_INTERRUPT) we do indeed need to make sure the HALTED state is reached

Not sure why I did not see the interrupt imbalance problem with phy_mac_interrupt...

I am out today but will follow up tomorrow. thanks!

-- 
Florian
