From: ben@decadent.org.uk (Ben Hutchings)
Date: Tue, 30 Sep 2014 12:38:08 +0100
Subject: [PATCH v2 3/5] spi-nor: Make spi_nor_scan() take a chip type
 name, not an spi_device_id
In-Reply-To: <CACna6ryNp7+4y7oSs60atDZhUwFhiAyV4Oq5ELi1gyen45zhVw@mail.gmail.com>
References: <1412043222.9388.81.camel@decadent.org.uk>
 <1412043317.9388.84.camel@decadent.org.uk>
 <CACna6ryNp7+4y7oSs60atDZhUwFhiAyV4Oq5ELi1gyen45zhVw@mail.gmail.com>
Message-ID: <1412077088.9388.98.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-09-30 at 07:14 +0200, Rafa? Mi?ecki wrote:
> On 30 September 2014 04:15, Ben Hutchings <ben@decadent.org.uk> wrote:
> > @@ -236,16 +236,13 @@ static int m25p_probe(struct spi_device *spi)
> >          * If that's the case, respect "type" and ignore a "name".
> >          */
> >         if (data && data->type)
> > -               id = spi_nor_match_id(data->type);
> > +               name = data->type;
> >
> >         /* If we didn't get name from platform, simply use "modalias". */
> > -       if (!id) {
> > -               id = spi_nor_match_id(spi_get_device_id(spi)->name);
> > -               if (WARN_ON(!id))
> > -                       return -ENODEV;
> > -       }
> > +       if (!name)
> > +               name = spi_get_device_id(spi)->name;
> 
> Huh? Iterating the whole id_table, checking the entries (looking for
> one with name equal to the spi->modalias) and then... getting that
> name?

Ah, I didn't realise what spi_get_device_id() was doing.

> Did it hurt to use the patch I've sent
> mtd: m25p80: get rid of spi_get_device_id
> https://patchwork.ozlabs.org/patch/394328/

It would make sense to insert that before this.

Ben.

-- 
Ben Hutchings
The two most common things in the universe are hydrogen and stupidity.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/a819adbf/attachment.sig>
