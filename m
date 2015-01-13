From: harinikatakamlinux@gmail.com (Harini Katakam)
Date: Tue, 13 Jan 2015 22:46:27 +0530
Subject: [PATCH v5 2/2] i2c: cadence: Check for errata condition involving
 master receive
In-Reply-To: <20150113113538.GB7660@katana>
References: <1418357907-4215-1-git-send-email-harinik@xilinx.com>
 <1418357907-4215-3-git-send-email-harinik@xilinx.com>
 <20150113113538.GB7660@katana>
Message-ID: <CAFcVECK6qYd=6MW=EPWpUHVbQRCVEpE21r15DUwVtZXyBQBoUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 13, 2015 at 5:05 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> @@ -541,6 +541,18 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>>        * processed with a repeated start.
>>        */
>>       if (num > 1) {
>> +             /*
>> +              * This controller does not give completion interrupt after a
>> +              * master receive transfer if HOLD bit is set (repeated start),
>> +              * resulting in SW timeout. Hence, if a receive transfer is
>> +              * followed by any other transfer, an error is returned
>> +              * indicating that this sequence is not supported.
>> +              */
>> +             for (count = 0; count < num-1; count++) {
>> +                     if (msgs[count].flags & I2C_M_RD)
>> +                             dev_warn(adap->dev.parent, "No support for repeated start when receive is followed by a transfer\n");
>> +                             return -EOPNOTSUPP;
>> +             }
>>               id->bus_hold_flag = 1;
>>               reg = cdns_i2c_readreg(CDNS_I2C_CR_OFFSET);
>>               reg |= CDNS_I2C_CR_HOLD;
>
> Have you ever tested this code? There is a huge bug in it :(

I'm sorry. I'll send another patch with the braces for the if statement.
I seem to have tested with only the return statement and no dev_warn.

>
> Also, in the comment, use "message" instead of "transfer". One transfer
> consists of multiple messages.
>
> Maybe the warning can be simplified, too: "can't do repeated start after
> read messages".
>
I'll do that.

Regards,
Harini
