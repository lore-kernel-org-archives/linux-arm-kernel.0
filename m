From: David.Laight@ACULAB.COM (David Laight)
Date: Fri, 13 Jan 2017 10:55:38 +0000
Subject: [PATCH net-next v2 05/10] drivers: base: Add device_find_class()
In-Reply-To: <81f5965c-3484-92d9-5c04-94c5b73735d0@gmail.com>
References: <20170112034121.27697-1-f.fainelli@gmail.com>
 <20170112034121.27697-6-f.fainelli@gmail.com>
 <20170112.162135.441956368122992032.davem@davemloft.net>
 <81f5965c-3484-92d9-5c04-94c5b73735d0@gmail.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB02620D3@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Fainelli
> Sent: 12 January 2017 22:51
> On 01/12/2017 01:21 PM, David Miller wrote:
> > From: Florian Fainelli <f.fainelli@gmail.com>
> > Date: Wed, 11 Jan 2017 19:41:16 -0800
> >
> >> Add a helper function to lookup a device reference given a class name.
> >> This is a preliminary patch to remove adhoc code from net/dsa/dsa.c and
> >> make it more generic.
...
> >> +static int dev_is_class(struct device *dev, void *class)
> >
> > I know you are just moving code, but this class argumnet is a string
> > and thus should be "char *" or even "const char *".
> 
> Well, this is really so that we don't need to cast the arguments passed
> to device_find_child(), which takes a void *data as well. If we made
> that a const char *class, we'd get warnings that look like these:
> 
> drivers/base/core.c: In function 'device_find_class':
> drivers/base/core.c:2083:2: warning: passing argument 2 of
> 'device_find_child' discards 'const' qualifier from pointer target type
> [enabled by default]
>   return device_find_child(parent, class, dev_is_class);
>   ^
> drivers/base/core.c:2050:16: note: expected 'void *' but argument is of
> type 'const char *'
>  struct device *device_find_child(struct device *parent, void *data,
>                 ^
...

Maybe device_find_child() needs changing to take 'const void *' ?

	David
