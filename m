From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 17 Feb 2018 09:18:57 +0100
Subject: [PATCH 1/2] ARM: shmobile: Factor out complex condition
In-Reply-To: <20180217020642.21375-1-marek.vasut+renesas@gmail.com>
References: <20180217020642.21375-1-marek.vasut+renesas@gmail.com>
Message-ID: <20180217081857.xowqahwnzob6titp@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -	if ((client->addr == 0x58 && !strcmp(client->name, "da9063")) ||
> -	    (client->addr == 0x68 && !strcmp(client->name, "da9210")) ||
> -	    (client->addr == 0x70 && !strcmp(client->name, "da9210"))) {
> +	if (regulator_quirk_check(client, 0, "da9063") ||
> +	    regulator_quirk_check(client, 1, "da9210") ||
> +	    regulator_quirk_check(client, 2, "da9210")) {

I am afraid I don't think this makes the code better, just different.
The index is as magic as the client address IMO. I was not super happy
with the array size depending on the detected board from a previous
patch already. But given the next patch which modifies the msg array
depending on the board, I think we really need to switch to seperate
message arrays per board. Everything else is too error prone and
unnecessarily cumbersome to understand.

Other opinions?

Regards,

   Wolfram
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180217/9a5d0088/attachment.sig>
