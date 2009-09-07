From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 07 Sep 2009 12:21:50 +0200
Subject: [PATCH] Add RGB555X and RGB565X formats to pxa-camera
In-Reply-To: <200909071050.11531.marek.vasut@gmail.com> (Marek Vasut's message
	of "Mon\, 7 Sep 2009 10\:50\:11 +0200")
References: <200908031031.00676.marek.vasut@gmail.com>
	<200909070646.04642.marek.vasut@gmail.com>
	<Pine.LNX.4.64.0909070818480.4822@axis700.grange>
	<200909071050.11531.marek.vasut@gmail.com>
Message-ID: <m2iqfvkqbl.fsf@arbois.toulouse.it.atosorigin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut <marek.vasut@gmail.com> writes:

> How's it supposed to get BGR555 if the pxa-camera doesnt support that ? Will the 
> v4l2 layer convert it or something ?

In pxa_camera.c, function pxa_camera_get_formats() :
>         default:
>                 /* Generic pass-through */
>                 formats++;
>                 if (xlate) {
>                         xlate->host_fmt = icd->formats + idx;
>                         xlate->cam_fmt = icd->formats + idx;
>                         xlate->buswidth = icd->formats[idx].depth;
>                         xlate++;
>                         dev_dbg(ici->dev,
>                                 "Providing format %s in pass-through mode\n",
>                                 icd->formats[idx].name);
>                 }
>         }

"Pass-through" means that if a sensors provides a cc, ie. BGR555 for example,
the bridge (pxa_camera) will "forward" to RAM the image in the very same cc
(ie. BGR555). In that case, the bridge is a dummy "sensor to RAM" bus translator
if you prefer.

Marek, you should activate debug trace and watch for yourself. You can trust
Guennadi, when he says it will work, well ... it will work.

If it's out of technical curiousity, check the function above.  If you're even
more curious, there was a thread in linux-media about "RFC: bus configuration
setup for sub-devices", a very interesting one, especially considering the
"pass-through" issue.

Cheers.

--
Robert
