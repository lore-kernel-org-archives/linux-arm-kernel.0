From: amworsley@gmail.com (Andrew Worsley)
Date: Wed, 18 Oct 2017 20:41:26 +1100
Subject: [PATCH] Fix Bug for cadence i2c interrupt overrunning buffer
In-Reply-To: <CAFcVECK85xW_8oxVQGsHBGyZ4_5bcghpbonqDH-8tLp+Mwq=xQ@mail.gmail.com>
References: <20170916030252.10680-1-amworsley@gmail.com>
 <20171005120125.nnhomwg2e2twbaqm@ninjato>
 <CA+Y=x3=Ab-tZt-32Ve1qTB=REuQAZnGbX72ZeNpyX3EX7cR0pg@mail.gmail.com>
 <20171013184646.cy5gmpwrxbacje3m@ninjato>
 <CAFcVECJTUu7Kwd-2hx=4=iGwKFnpTAebR3ffjJHQLHKDZ3T4aw@mail.gmail.com>
 <CA+Y=x3nnQ0hQkBaGQ4+MDZsVgpdFCYqaMae9UrJ2vOOuAD9FdQ@mail.gmail.com>
 <CAFcVECK85xW_8oxVQGsHBGyZ4_5bcghpbonqDH-8tLp+Mwq=xQ@mail.gmail.com>
Message-ID: <CA+Y=x3kpy0LE-mqjKWS8QWy7qzS2pNdDMHpDqZXRGvdt-UbYcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 October 2017 at 21:38, Harini Katakam
<harinikatakamlinux@gmail.com> wrote:
> Hi Andrew,

Hi Harini, I did manage to reproduce the issue and got some more info
on  the bug some more
- but I don't  really understanding the cause.

> On Mon, Oct 16, 2017 at 2:48 PM, Andrew Worsley <amworsley@gmail.com> wrote:
>> Thanks I think I know understand how this transfer register is set up.
>> I will add some diagnostic printk's to track down exactly how it is
>> failing and get back to you.


It appears to be working fine and then just fails with  the transfer
size register value set to 242.
Always the value 240 or  242 in the transfer register.

>>
>>  Yes it is zynq. The test case is large (128 byte) transfers from a
>> tpm to fill an rng driver. I just pull large amounts of data via dd.
>>

I have a lot of data so I will summarise it and I can post more
details on what people want to know.

I added printk's on each i2c operation and each write to the transfer
size register.
When the overrun is hit it prints out most of the registers, about
half the time the overflow bit is set.

Here is my last output which has the most diagnostics:
...
[   15.607821] zs2 kernel: cdns_i2c_process_msg: Rd len=142 #8
[   15.607826] zs2 kernel: cdns_i2c_mrecv:cdns_i2c_writereg(142,
CDNS_I2C_XFER_SIZE_OFFSET)
 #6
[   15.611343] zs2 kernel: cdns_i2c_process_msg: Wr len=14 #8
[   15.611777] zs2 kernel: cdns_i2c_process_msg: Rd len=35 #8
[   15.611781] zs2 kernel: cdns_i2c_mrecv:cdns_i2c_writereg(35,
CDNS_I2C_XFER_SIZE_OFFSET)
#6
[   15.611836] zs2 kernel: cdns_i2c_master_reset:cdns_i2c_writereg(0,
CDNS_I2C_XFER_SIZE_OF
FSET) #4
[   15.612847] zs2 kernel: cdns_i2c_process_msg: Rd len=35 #8
[   15.612850] zs2 kernel: cdns_i2c_mrecv:cdns_i2c_writereg(35,
CDNS_I2C_XFER_SIZE_OFFSET)
#6
[   15.612911] zs2 kernel: cdns_i2c_master_reset:cdns_i2c_writereg(0,
CDNS_I2C_XFER_SIZE_OF
FSET) #4
[   15.613924] zs2 kernel: cdns_i2c_process_msg: Rd len=35 #8
[   15.613928] zs2 kernel: cdns_i2c_mrecv:cdns_i2c_writereg(35,
CDNS_I2C_XFER_SIZE_OFFSET)
#6
[   15.614836] zs2 kernel: tpm_transmit: after req_complete_val status=0x1
[   15.614846] zs2 kernel: cdns_i2c_process_msg: Rd len=142 #8
[   15.614851] zs2 kernel: cdns_i2c_mrecv:cdns_i2c_writereg(142,
CDNS_I2C_XFER_SIZE_OFFSET)
 #6
[   15.626087] zs2 kernel: cdns_i2c_isr: buffer overrunning !!!-
transfer-size=242 ctrl=0xc0f status=0x120 int-status=0x0
[   15.626091] zs2 kernel: cdns_i2c_isr:Aborting transfer...
....

I tried to handle situation by setting the transfer register to zero
and breaking out of the loop which is copying bytes out of the FIFO.
At no time are any of the transfers bigger than 142 bytes or so as
shown above. So the driver  always sets the transfer register to the
full size.

The only writes to the transfer register are 0,  1, 35 and 142. I
never see an overly large write to the transfer register.

>>> Could you please provide more details of your application and
>>> setup?
>>>
>>> Regards,
>>> Harini
>>

I originally discovered the flaw with two of the last i2c-cadence
driver fixes not present

  Initialize-configuration-before-prob
  fix-ctrl-addr-reg-write-order

 and a fair amount of debug in the TPM driver - then the bug hit
nearly every run.
With these two i2c fixes in it occured only once per 4-5 runs.

Perhaps this information gives some one a path to investigate further?
I can't really see how this transfer size register can get confused -
especially always with 240 or 242 = 255-13
Perhaps the transfer register rolls over from zero or something?
Or Perhaps I am just looking for magic numbers?


>>
>> Assuming it is not obvious how to fix it - perhaps I can try setting
>> the transfer register to zero when it hits the end of the transfer?
>> (if recv_count == 0).
>
> Yes, that can be done as a workaround but ideally, the transfer
> size register should have decremented to zero by this point.

Setting the transfer size to zero and then doing a break on an error
is ok but causes the transfer to fail still.
Now thinking about it perhaps I should have done a continue - so the
loop would terminate more naturally.

>>
>> Thanks very much Harini  - that was just the pointer I needed to
>> follow the code.
>
> Thanks for the information - please let me know what you find.
>
> Regards,
>

Let me know if you have any other suggestions for me to try. my tpm
driver changes are not in main line so it's hard for anyone else to do
exactly that test case.
I can't get back to this till next week so I won't be able to try this
till then.
My thoughts are to remove the TPM debugging code to confirm that no
other changes are needed to reproduce this issue.
But I can't see how anything can overwrite the transfer register.

> Harini

I attach a patch of the changes to the i2c driver showing my debug in
this driver.
As I said I am happy to send more verbose bug output - I have about 36
odd runs with 9 occurences of the bug.
Once it happen twice in the one run

I include the crashing line from the runs where the bug occured (I
added more diagnostics as the runs progressed):
% grep overrunning i2c-tpm-run*
i2c-tpm-run12-bad-rev-ecbd28b9.txt:[    8.543441] zs2 kernel:
cdns_i2c_isr: buffer overrunning !!!- transfer-size=242
i2c-tpm-run13-bad-rev-ecbd28b9.txt:[   16.193018] zs2 kernel:
cdns_i2c_isr: buffer overrunning !!!- transfer-size=242
i2c-tpm-run18-bad-rev-ecbd28b9.txt:[   26.065783] zs2 kernel:
cdns_i2c_isr: buffer overrunning !!!- transfer-size=240 ctrl=0xc0f
status=0xa0 int-status=0x0
i2c-tpm-run18-bad-rev-ecbd28b9.txt:[   30.272113] zs2 kernel:
cdns_i2c_isr: buffer overrunning !!!- transfer-size=240 ctrl=0xc0f
status=0xa0 int-status=0x0
i2c-tpm-run21-bad-rev-ecbd28b9.txt:[   20.162880] zs2 kernel:
cdns_i2c_isr: buffer overrunning !!!- transfer-size=240 ctrl=0xc0f
status=0xa0=>Overflow<= int-status=0x0
i2c-tpm-run24-bad-rev-ecbd28b9.txt:[   15.191316] zs2 kernel:
cdns_i2c_isr: buffer overrunning !!!- transfer-size=242 ctrl=0xc0f
status=0x120 int-status=0x0
i2c-tpm-run26-bad-rev-ecbd28b9.txt:[   18.370014] zs2 kernel:
cdns_i2c_isr: buffer overrunning !!!- transfer-size=240 ctrl=0xc0f
status=0xa0=>Overflow<= int-status=0x0
i2c-tpm-run30-bad-rev-ecbd28b9.txt:[   20.177092] zs2 kernel:
cdns_i2c_isr: buffer overrunning !!!- transfer-size=242 ctrl=0xc0f
status=0x120 int-status=0x0
i2c-tpm-run36-bad-rev-ecbd28b9.txt:[   15.626087] zs2 kernel:
cdns_i2c_isr: buffer overrunning !!!- transfer-size=242 ctrl=0xc0f
status=0x120 int-status=0x0

I attach the diff of the changes to the i2c-cadence driver file

Suggestions appreciated.

Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-cadence.patch
Type: text/x-patch
Size: 4208 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171018/8bc91cd8/attachment.bin>
