From: jic23@kernel.org (Jonathan Cameron)
Date: Mon, 3 Sep 2018 18:29:27 +0100
Subject: [PATCH v3 18/30] iio: adc: sun4i-gpadc-iio: rework: support
 multiple sensors
In-Reply-To: <3722842b-1aa3-ea46-c0ec-7a01bc8a723e@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-19-embed3d@gmail.com>
 <20180902211125.0098c808@archlinux>
 <3722842b-1aa3-ea46-c0ec-7a01bc8a723e@gmail.com>
Message-ID: <20180903182927.344858c4@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 3 Sep 2018 15:58:30 +0200
Philipp Rossak <embed3d@gmail.com> wrote:

> On 02.09.2018 22:11, Jonathan Cameron wrote:
> > This feels like a good place to factor out the code into a utility
> > function that just does one of them.  That should hopefully
> > reduce the indenting etc enough to make the code easier to read.
> >   
> >> +		info->tzds[i].info = info;
> >> +		info->tzds[i].sensor_id = i;
> >> +
> >> +		info->tzds[i].tzd = thermal_zone_of_sensor_register(
> >> +				info->sensor_device,
> >> +				i, &info->tzds[i], &sun4i_ts_tz_ops);
> >> +		/*
> >> +		 * Do not fail driver probing when failing to register in
> >> +		 * thermal because no thermal DT node is found.
> >> +		 */
> >> +		if (IS_ERR(info->tzds[i].tzd) && \
> >> +				PTR_ERR(info->tzds[i].tzd) != -ENODEV) {
> >> +			dev_err(&pdev->dev,
> >> +				"could not register thermal sensor: %ld\n",
> >> +				PTR_ERR(info->tzds[i].tzd));
> >> +			return PTR_ERR(info->tzds[i].tzd);
> >> +		}  
> 
> So this code above should be placed in a separate function and called by 
> the for loop?
> Did I understand that right?
Yes - exactly.

> 
> Philipp
