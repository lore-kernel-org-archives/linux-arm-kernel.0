From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 17 Feb 2018 12:46:01 +0100
Subject: [PATCH 1/2] ARM: shmobile: Factor out complex condition
In-Reply-To: <20180217081857.xowqahwnzob6titp@katana>
References: <20180217020642.21375-1-marek.vasut+renesas@gmail.com>
 <20180217081857.xowqahwnzob6titp@katana>
Message-ID: <e22632bc-c612-de23-0ceb-4e317d41b04b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/17/2018 09:18 AM, Wolfram Sang wrote:
>> -	if ((client->addr == 0x58 && !strcmp(client->name, "da9063")) ||
>> -	    (client->addr == 0x68 && !strcmp(client->name, "da9210")) ||
>> -	    (client->addr == 0x70 && !strcmp(client->name, "da9210"))) {
>> +	if (regulator_quirk_check(client, 0, "da9063") ||
>> +	    regulator_quirk_check(client, 1, "da9210") ||
>> +	    regulator_quirk_check(client, 2, "da9210")) {
> 
> I am afraid I don't think this makes the code better, just different.
> The index is as magic as the client address IMO. I was not super happy
> with the array size depending on the detected board from a previous
> patch already. But given the next patch which modifies the msg array
> depending on the board, I think we really need to switch to seperate
> message arrays per board. Everything else is too error prone and
> unnecessarily cumbersome to understand.
> 
> Other opinions?

The code is awful, yes.

I wonder if we could rather find all DA0063 and DA9210 PMICs in the DT,
check if their IRQ lines are tied together and then generate the table
above dynamically for whatever PMICs are present in the system. Then all
that special-casing would go away as we'd extract the information from DT.

-- 
Best regards,
Marek Vasut
