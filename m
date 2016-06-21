From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 21 Jun 2016 09:44:28 +0100
Subject: [PATCH 1/3] arm64: dts: juno: add coresight support
In-Reply-To: <CAOesGMjQNEOcmYpUAxUxBJLyUYZQuRKK48a31Ys9LuTJFWqMFA@mail.gmail.com>
References: <1465228765-14038-1-git-send-email-sudeep.holla@arm.com>
 <1465228765-14038-2-git-send-email-sudeep.holla@arm.com>
 <CAOesGMjQNEOcmYpUAxUxBJLyUYZQuRKK48a31Ys9LuTJFWqMFA@mail.gmail.com>
Message-ID: <5768FE6C.3080809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/06/16 06:41, Olof Johansson wrote:

Hi Olof,


>> +       /*
>> +        * Juno TRMs specify the size for these coresight components as 64K.
>> +        * The actual size is just 4K though 64K is reserved. Access to the
>> +        * unmapped reserved region results in a DECERR response.
>> +        */
>> +       etf at 20010000 {
>


> Would it make sense to name it something like trace-fifo instead? We
> normally name the nodes based on type of device (ethernet@, pci@,
> etc).

ETF (Embedded Trace FIFO) is one of the modes[1] in which you can configure
the Coresight TMC at integration time. The other available modes are
ETR(Embedded Trace Router) and ETB(Embedded Trace Buffer).

>
>
>> +               compatible = "arm,coresight-tmc", "arm,primecell";
>
> Is there a more specific compatible needed here, or does
> arm,coresight-tmc give you all the information you need on how to use
> this interface?

The coresight TMC driver will read the "configured mode" to determine
the mode of operation and initialise it accordingly. Hence we don't
need a specific compatible.

>
> The bindings doc is sort of sparse in this area, all it says is "you
> might use one of these compatibles".

I agree.

>
>> +       tpiu at 20030000 {
>
> Again, these names are not great. Luckily they don't affect the
> binding, so they can be fixed. What would be a more human readable and
> functionally describing name here?

Again, TPIU (Trace Port Interface Unit), is standard Coresight component in
Coresight architecture. [2]


>> +
>> +       etr at 20070000 {
>
> Again..
>

Same as ETF [1]

>> +
>> +       etm0: etm at 22040000 {
>
> If this file is sorted on reg values, then this node and the two after
> are out of order.

They are numbered after the CPU which they are associated with. This is used
to reuse the dts for Juno-r0/r1 vs r2 (where we have A72 replacing A57).


[1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0461b/CACECIII.html
[2] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0314h/Babhdhfb.html


Cheers
Suzuki
