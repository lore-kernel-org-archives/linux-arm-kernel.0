From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Fri, 6 Apr 2018 18:54:21 +0300
Subject: [PATCH v3 3/6] spi: sun6i: restrict transfer length in PIO-mode
In-Reply-To: <20180406073441.xesojvzc3deljhoy@flea>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
 <20180403154449.2443-4-ssuloev@orpaltech.com>
 <20180404065048.n76r3ytuznd6fqsl@flea>
 <a6044902-8977-3ce1-d7d5-c6797341a5d0@orpaltech.com>
 <20180405091913.ky4dnmszoobn2xry@flea>
 <ee4adb1e-caf6-32f6-33d6-d8dd94d232cf@orpaltech.com>
 <20180405131735.GB12349@sirena.org.uk>
 <8159c3a5-af74-9f13-aedb-7ecc708bdff6@orpaltech.com>
 <20180406073441.xesojvzc3deljhoy@flea>
Message-ID: <46df9f95-a93f-57af-b7d9-dfd5db046622@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2018 10:34 AM, Maxime Ripard wrote:
> On Thu, Apr 05, 2018 at 04:44:16PM +0300, Sergey Suloev wrote:
>> On 04/05/2018 04:17 PM, Mark Brown wrote:
>>> On Thu, Apr 05, 2018 at 12:59:35PM +0300, Sergey Suloev wrote:
>>>> On 04/05/2018 12:19 PM, Maxime Ripard wrote:
>>>>> The point of that patch was precisely to allow to send more data than
>>>>> the FIFO. You're breaking that behaviour without any justification,
>>>>> and this is not ok.
>>>> I am sorry, but you can't. That's a hardware limitation.
>>> Are you positive about that?  Normally you can add things to hardware
>>> FIFOs while they're being drained so so long as you can keep data
>>> flowing in at least as fast as it's being consumed.
>> Well, normally yes, but this is not the case with the hardware that I own.
>> My a20 (BPiM1+) and a31 (BPiM2) boards behaves differently. With a transfer
>> larger than FIFO then TC interrupt never happens.
> Because you're not supposed to have a transfer larger than the FIFO,
> but to have to setup at first a transfer the size of the FIFO, and
> then when it's (or starts to be) depleted, fill it up again.
According to what you said the driver must implement 
"transfer_one_message" instead of "transfer_one",
because the maximum transfer length is 64 bytes (for sun4i) and we 
shouldn't allow "transfer_one" handle
more than 64 bytes. Otherwise it breaks the concept.
>
> That's the point of the patch you're reverting, and if it doesn't
> work, you should make it work and not simply revert it.
>
> Maxime
>
