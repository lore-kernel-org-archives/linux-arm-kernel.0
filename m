From: robh@kernel.org (Rob Herring)
Date: Wed, 19 Apr 2017 15:47:23 -0500
Subject: [PATCH v3 3/4] bluetooth: hci_uart: add LL protocol serdev driver
 support
In-Reply-To: <CAHCN7xLNcD1rmifEOyPhG2rpB_C81hsyzV9W2q6kCQkKa69sZg@mail.gmail.com>
References: <20170413150353.7389-1-robh@kernel.org>
 <20170413150353.7389-4-robh@kernel.org>
 <CAHCN7xLNcD1rmifEOyPhG2rpB_C81hsyzV9W2q6kCQkKa69sZg@mail.gmail.com>
Message-ID: <CAL_JsqKv=pYRTxE4H81DTiUqzgSU0tVDPKBQ+WPo=VJOBNTu9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 17, 2017 at 3:11 PM, Adam Ford <aford173@gmail.com> wrote:
> On Thu, Apr 13, 2017 at 10:03 AM, Rob Herring <robh@kernel.org> wrote:
>> Turns out that the LL protocol and the TI-ST are the same thing AFAICT.
>> The TI-ST adds firmware loading, GPIO control, and shared access for
>> NFC, FM radio, etc. For now, we're only implementing what is needed for
>> BT. This mirrors other drivers like BCM and Intel, but uses the new
>> serdev bus.
>>
>> The firmware loading is greatly simplified by using existing
>> infrastructure to send commands. It may be a bit slower than the
>> original code using synchronous functions, but the real bottleneck is
>> likely doing firmware load at 115.2kbps.
>
> I am using pdata-quirks to drive my wl1283 Bluetooth on a DM3730.  I
> have the Bluetooth set to 3000000 baud in pdata quirks.  Looking at
> the binding, I don't see an option to set the baudrate.  Is there (or
> will there) be a way to set the baud rate of the Bluetooth?

If you read hci_ti_probe, you will see it is already there. The
default is 3Mbps and the DT can override that with "max-speed". The
intent is that 3Mbps is the max the device can do and max-speed is
only for board or host limitations. Though I just checked the
datasheet on the 1835 and it can go up to 4364kbps. No datasheets for
wl1283, so I have no idea what the max is.

>> +static int hci_ti_probe(struct serdev_device *serdev)
>> +{
>> +       struct hci_uart *hu;
>> +       struct ll_device *lldev;
>> +       u32 max_speed = 3000000;

[...]

>> +       of_property_read_u32(serdev->dev.of_node, "max-speed", &max_speed);
>> +       hci_uart_set_speeds(hu, 115200, max_speed);
