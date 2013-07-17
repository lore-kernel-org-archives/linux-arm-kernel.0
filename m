From: bp@alien8.de (Borislav Petkov)
Date: Wed, 17 Jul 2013 23:44:42 +0200
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <20130717211649.GA5619@merkur.ravnborg.org>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <20130716004727.b60b2c96.akpm@linux-foundation.org>
 <20130716005611.e4ccab02.akpm@linux-foundation.org>
 <201307161008.07643.yann.morin.1998@free.fr>
 <20130716180408.GA19863@merkur.ravnborg.org>
 <20130717211649.GA5619@merkur.ravnborg.org>
Message-ID: <20130717214441.GB4454@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 11:16:49PM +0200, Sam Ravnborg wrote:
> +
> +static void exec_command(const char *command, struct symbol *sym)
> +{
> +	char buffer[2048];
> +	FILE *stream;

Just some indentation level saving:

> +
> +	stream = popen(command, "r");
> +
> +	if (stream != NULL) {

	if (!stream) {
		menu_warn(current_entry, "command '%s' failed to execute", command);
		return;
	}

and the rest starts one level less to the right:

	if (fgets(buffer, sizeof(buffer), stream) != NULL) {
		int i;

		buffer[sizeof(buffer) - 1] = '\0';

and so on...

> +
> +			/* Drop any trialing newlines */
> +			i = strlen(buffer);
> +			while (i > 0 && buffer[i - 1] == '\n') {
> +				buffer[i - 1] = '\0';
> +				i--;
> +			}
> +			/* Validate the output of the command */
> +			if (strlen(buffer) == 0) {
> +				menu_warn(current_entry,
> +				          "command '%s' - invalid (empty?) return value: \"%s\"",
> +				          command, buffer);
> +				return;
> +			}
> +
> +			menu_warn(current_entry, "default: %s", buffer);
> +			sym_add_default(sym, buffer);
> +		} else {
> +			menu_warn(current_entry, "command '%s' - empty return value", command);
> +		}
> +		pclose(stream);
> +	} else {
> +		menu_warn(current_entry, "command '%s' failed to execute", command);
> +	}
> +}

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
