From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Tue, 30 Sep 2014 07:14:15 +0200
Subject: [PATCH v2 3/5] spi-nor: Make spi_nor_scan() take a chip type
 name, not an spi_device_id
In-Reply-To: <1412043317.9388.84.camel@decadent.org.uk>
References: <1412043222.9388.81.camel@decadent.org.uk>
 <1412043317.9388.84.camel@decadent.org.uk>
Message-ID: <CACna6ryNp7+4y7oSs60atDZhUwFhiAyV4Oq5ELi1gyen45zhVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 September 2014 04:15, Ben Hutchings <ben@decadent.org.uk> wrote:
> @@ -236,16 +236,13 @@ static int m25p_probe(struct spi_device *spi)
>          * If that's the case, respect "type" and ignore a "name".
>          */
>         if (data && data->type)
> -               id = spi_nor_match_id(data->type);
> +               name = data->type;
>
>         /* If we didn't get name from platform, simply use "modalias". */
> -       if (!id) {
> -               id = spi_nor_match_id(spi_get_device_id(spi)->name);
> -               if (WARN_ON(!id))
> -                       return -ENODEV;
> -       }
> +       if (!name)
> +               name = spi_get_device_id(spi)->name;

Huh? Iterating the whole id_table, checking the entries (looking for
one with name equal to the spi->modalias) and then... getting that
name?

Did it hurt to use the patch I've sent
mtd: m25p80: get rid of spi_get_device_id
https://patchwork.ozlabs.org/patch/394328/
