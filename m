From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 02 Mar 2017 08:42:51 +0100
Subject: [PATCH v6 2/2] [media] s5p-mfc: Handle 'v4l2_pix_format:field' in
 try_fmt and g_fmt
In-Reply-To: <1488381666.14858.5.camel@collabora.com>
References: <20170301115108.14187-1-thibault.saunier@osg.samsung.com>
 <CGME20170301115141epcas2p37801b1fbe0951cc37a4e01bf2bcae3da@epcas2p3.samsung.com>
 <20170301115108.14187-3-thibault.saunier@osg.samsung.com>
 <33dbd3fa-04b2-3d94-5163-0a10589ff1c7@samsung.com>
 <1488381666.14858.5.camel@collabora.com>
Message-ID: <54862f6b-290d-7e87-4297-57ffc35d357a@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.03.2017 16:21, Nicolas Dufresne wrote:
> Le mercredi 01 mars 2017 ? 14:12 +0100, Andrzej Hajda a ?crit :
>> - on output side you have encoded bytestream - you cannot say about
>> interlacing in such case, so the only valid value is NONE,
>> - on capture side you have decoded frames, and in this case it
>> depends
>> on the device and driver capabilities, if the driver/device does not
>> support (de-)interlacing (I suppose this is MFC case), interlace type
>> field should be filled according to decoded bytestream header (on
>> output
>> side), but no direct copying from output side!!!
> I think we need some nuance here for this to actually be usable. If the
> information is not provided by the driver (yes, hardware is limiting
> sometimes), it would make sense to copy over the information that
> userspace provided. Setting NONE is just the worst approximation in my
> opinion.

The whole point is that s_fmt on output side is to describe format of
the stream passed to the device, and in case of decoder it is just
mpeg/h.26x/... stream. It does not contain frames, fields, width, height
- it is just raw stream of bytes. We cannot say in such case about field
type, there is not such thing as interlaced byte stream.
Using s_fmt on output to describe things on capture side look for me
unnecessary and abuses V4L2 API IMO.

>
> About MFC, it will be worth trying to read the DISPLAY_STATUS after the
> headers has been processed. It's not clearly stated in the spec if this
> will be set or not.
>
Documentation for MFC6.5 states clearly:

> Note: On SEQ_DONE, INTERLACE_PICTURE will return the picture type to
> be decoded based on the
> sequence header information.

In case of MFC5.1 it is unclear, but I hope HW behaves the same way.

Anyway I agree it will be good to fix it at least for MFC6.5+, any
volunteer?


Regards

Andrzej
